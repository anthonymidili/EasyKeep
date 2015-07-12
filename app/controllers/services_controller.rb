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

    set_current_account_cookie
  end

  def edit
  end

  def update
    if @service.update_attributes(service_params)
      redirect_to_account_or_invoice
    else
      render :edit
    end
  end

  def destroy
    @service.destroy

    redirect_to current_account, alert: 'Service history item successfully deleted.'
  end

  def history_search
    @services = current_account.services.by_selected_range(view_by, active_date).page(params[:page]).per(20).includes(invoice: [:account, :payments])
  end

private

  # Never trust parameters from the scary internet, only allow the white list through.
  def service_params
    params.require(:service).permit(:memo, :performed_on, :cost)
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

  def set_current_account_cookie
    if @service.save
      cookies[:current_account] = @account.id if current_user.is_admin?
      redirect_to dashboard_path, notice: "Service was successfully created for #{@account.name} Account."
    else
      render 'dashboard/home'
    end
  end

end
