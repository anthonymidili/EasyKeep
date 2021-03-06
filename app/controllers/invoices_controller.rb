class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!, except: [:show, :index]
  before_action :load_invoice, only: [:show, :apply_services_update, :remove_services_update,
                                      :invoice_ready, :change_account_header]
  before_action :require_no_payments!, only: [:edit, :update, :destroy]

  def show
    @services = @invoice.services
    @payments = @invoice.payments
  end

  def index
    @invoices =
        if current_user.is_admin?
          current_account.invoices.page(params[:page]).per(20).includes(:payments)
        else
          current_account.invoices.page(params[:page]).per(20)
        end
  end

  def new
    @invoice = current_company.invoices.build
    @invoice.established_at ||= Date.current
    @invoice.sales_tax ||= current_company.sales_tax
    @invoice.build_account
    @invoice.account.build_user
    @invoice.services.build
  end

  def create
    @account = current_company.find_or_create_account(invoice_params[:account_attributes])
    @invoice = @account.invoices.build(invoice_params)
    @invoice.company = current_company
    @invoice.services.each { |s| s.company = current_company; s.account = @account }

    if @invoice.save
      set_current_account_after_save(@invoice.account_id)
      redirect_to invoice_path(@invoice), notice: 'Invoice was successfully created.'
    else
      render :new
    end
  end

  def apply_checked_services_create
    @account = current_account
    @service = @account.services.build
    @service.performed_on ||= Date.current
    @services = @account.services.includes(:invoice)
    @invoices = @account.invoices.includes(:payments, :account).by_outstanding
    @invoice = @account.invoices.build(invoice_params)
    @invoice.company_id = current_company.id

    apply_invoice_ids
  end

  def edit
    @services = current_account.services
    @service = current_account.services.build
    @service.performed_on ||= Date.current
  end

  def update
    @services = current_account.services

    if @invoice.update_attributes(invoice_params)
      redirect_to edit_invoice_path(@invoice), notice: 'Invoice was successfully updated.'
    else
      render :edit
    end
  end

  def apply_services_update
    ActiveRecord::Base.transaction do
      @services = current_account.services

      @services.where(id: params[:service_ids]).update_all(invoice_id: @invoice.id)

      redirect_to edit_invoice_path(@invoice), notice: 'Successfully added services to invoice.'
    end
  end

  def remove_services_update
    ActiveRecord::Base.transaction do
      @invoice.services.where(id: params[:service_ids]).update_all(invoice_id: nil)

      redirect_to edit_invoice_path(@invoice), notice: 'Successfully removed services from invoice.'
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @services = current_account.services

      @invoice.services.update_all(invoice_id: nil)
      @invoice.destroy

      redirect_to account_path(current_account), alert: 'Invoice was successfully deleted. Services on invoice are ready to be
re-invoiced.'
    end
  end

  def invoice_ready
    UserMailer.invoice_ready_notice(@invoice).deliver

    redirect_to @invoice, notice: "Email has been successfully sent to #{@invoice.account.user.name}."
  end

  def change_account_header
    ActiveRecord::Base.transaction do
      if current_account.update_attributes(account_params)
        redirect_to edit_invoice_path(@invoice), notice: "Account was successfully updated for all current and future
invoices for #{current_account.name} Account."
      else
        redirect_to edit_invoice_path(@invoice), alert: 'Something went wrong. Please try again.'
      end
    end
  end

private

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    params.require(:invoice).permit(:established_at, :sales_tax, :number,
                                    account_attributes: [:id, :name, :address_1, :address_2, :city, :fax, :phone, :state, :zip,
                                                         :uses_account_name, :uses_contact_name, :prefix, :postfix, :divider,
                                                         user_attributes: [:id, :name, :email, :password,
                                                                           :password_confirmation, :remember_me]],
                                    services_attributes: [:id, :memo, :performed_on, :cost])
  end

  def account_params
    params.require(:account).permit(:uses_account_name, :uses_contact_name)
  end

  def load_invoice
    @invoice = current_account.invoices.friendly.find(params[:id])
  end

  def require_no_payments!
    @invoice = current_account.invoices.friendly.find(params[:id])
    redirect_to @invoice, alert: 'INVOICES can only be EDITED or DELETED when no payments are applied!' if @invoice.payments.any?
  end

  def apply_invoice_ids
    ActiveRecord::Base.transaction do
      if @invoice.save
        @services.where(id: params[:service_ids]).update_all(invoice_id: @invoice.id)

        redirect_to invoice_path(@invoice), notice: "#{'Service'.pluralize(params[:service_ids].count)} successfully invoiced."
      else
        render 'accounts/show'
      end
    end
  end
end
