class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!, except: [:show, :index]
  before_action :require_no_payments!, only: [:edit, :update, :destroy]

  def show
    @invoice = current_account.invoices.find(params[:id])
    @services = @invoice.services
    @payments = @invoice.payments
  end

  def index
    @invoices = current_account.invoices.page(params[:page]).per(20)
  end

  def create
    @account = current_account
    @service = @account.services.build
    @service.performed_on ||= Date.current
    @services = @account.services
    @invoices = @account.invoices.by_outstanding
    @invoice = @account.invoices.build(invoice_params)
    @invoice.company_id = current_company.id
    @invoice.number = Invoice.set_invoice_number(current_company)

    create_invoice
  end

  def edit
    @services = current_account.services
  end

  def update
    @services = current_account.services

    if @invoice.update_attributes(invoice_params)
      redirect_to edit_invoice_path(@invoice), notice: 'Invoice was successfully updated.'
    else
      render :edit
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

  def add_services
    ActiveRecord::Base.transaction do
      @invoice = current_account.invoices.find(params[:id])
      @services = current_account.services

      @services.where(id: params[:service_ids]).update_all(invoice_id: @invoice.id)

      redirect_to edit_invoice_path(@invoice), notice: 'Successfully added services to invoice.'
    end
  end

  def remove_services
    ActiveRecord::Base.transaction do
      @invoice = current_account.invoices.find(params[:id])

      @invoice.services.where(id: params[:service_ids]).update_all(invoice_id: nil)

      redirect_to edit_invoice_path(@invoice), notice: 'Successfully removed services from invoice.'
    end
  end

  def invoice_ready
    @invoice = current_account.invoices.find(params[:id])
    UserMailer.invoice_ready_notice(@invoice).deliver

    redirect_to @invoice, notice: "Email has been successfully sent to #{@invoice.account.user.name}."
  end

  def change_account_header
    ActiveRecord::Base.transaction do
      @invoice = current_account.invoices.find(params[:id])
      current_account.update_attributes(account_params)

      redirect_to edit_invoice_path(@invoice), notice: "Account was successfully updated for all current and future
invoices for #{current_account.name} Account."
    end
  end

private

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    params.require(:invoice).permit(:established_at, :sales_tax)
  end

  def account_params
    params.require(:account).permit(:uses_account_name, :uses_contact_name)
  end

  def require_no_payments!
    @invoice = current_account.invoices.find(params[:id])
    redirect_to @invoice, alert: 'INVOICES can only be EDITED or DELETED when no payments are applied!' if @invoice.payments.any?
  end

  def create_invoice
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
