class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def create
    @services = current_account.services
    @service = current_account.services.build(service_params)
    @account = current_account

    if @service.save
      redirect_to current_account, notice: 'Service was successfully created.'
    else
      render 'accounts/show'
    end
  end

  def edit
    @service = current_account.services.find(params[:id])
  end

  def update
    @service = current_account.services.find(params[:id])

    if @service.update_attributes(params[:service])
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
    ActiveRecord::Base.transaction do
      @invoice = current_account.invoices.build(params[:invoice])
      @invoice.company_id = current_company.id
      @invoice.established_at = Date.current

      if @invoice.save
        @services = current_account.services
        @services.where(id: params[:service_ids]).update_all(invoice_id: @invoice.id)

        redirect_to invoice_path(@invoice)
      else
        redirect_to current_account, alert: 'There was a problem creating a new invoice. Please try again.'
      end
    end
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
end
