class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!, except: [:history_search]
  before_action :require_no_payments!, only: [:edit, :update, :destroy]

  def create
    @account = current_account
    @services = current_account.services
    @service = current_account.services.build(service_params)
    @service.company_id = current_company.id
    @invoice = current_account.invoices.build
    @invoices = @account.invoices.by_outstanding

    if @service.save
      redirect_to current_account, notice: 'Service was successfully created.'
    else
      render 'accounts/show'
    end
  end

  # Create a new service from the admin dashboard
  def dashboard_create
    @account = current_company.accounts.find(params[:service][:account_id])
    @accounts = current_company.accounts.by_recent_activity.with_limit
    @service = @account.services.build(service_params)
    @service.company_id = current_company.id

    if @service.save
      redirect_to dashboard_path, notice: "Service was successfully created for #{@account.name} Account."
    else
      render 'dashboard/home'
    end
  end

  def edit
    @service = current_account.services.find(params[:id])
  end

  def update
    @service = current_account.services.find(params[:id])

    if @service.update_attributes(service_params)
      redirect_to_account_or_invoice
    else
      render :edit
    end
  end

  def destroy
    @service = current_account.services.find(params[:id])
    @service.destroy

    redirect_to current_account, alert: 'Service history item successfully deleted.'
  end

  def invoice
    @account = current_account
    @service = @account.services.build
    @service.performed_on ||= Date.current
    @services = @account.services
    @invoices = @account.invoices.by_outstanding
    @invoice = @account.invoices.build(invoice_params)
    @invoice.company_id = current_company.id

    create_invoice
  end

  def history_search
    @account = current_account
    @services = @account.services
  end

private

  # Never trust parameters from the scary internet, only allow the white list through.
  def service_params
    params.require(:service).permit(:memo, :performed_on, :cost)
  end

  def invoice_params
    params.require(:invoice).permit(:established_at, :sales_tax)
  end

  def redirect_to_account_or_invoice
    if params[:invoice_id] && !@service.invoice.nil?
      redirect_to edit_invoice_path(@service.invoice), notice: 'Service was successfully updated.'
    else
      redirect_to current_account, notice: 'Service was successfully updated.'
    end
  end

  def require_no_payments!
    @service = current_account.services.find(params[:id])
    @invoice = @service.invoice

    redirect_to @invoice, alert: 'SERVICES can only be EDITED or DELETED when no payments are applied!' if @service.invoice_id.present? && @invoice.payments.any?
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
