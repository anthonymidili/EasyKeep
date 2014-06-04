class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!, except: [:show, :index]
  before_action :set_current_account_id, only: [:index, :show]
  before_action :require_no_payments, only: [:edit, :update, :destroy]

  def show
    @invoice = current_account.invoices.find(params[:id])
    @services = @invoice.services
    @payments = @invoice.payments
  end

  def index
    @invoices = current_account.invoices.page(params[:page]).per(10)
  end

  def edit
    @invoice = current_account.invoices.find(params[:id])
    @services = current_account.services
  end

  def update
    @invoice = current_account.invoices.find(params[:id])
    @services = current_account.services

    if @invoice.update_attributes(invoice_params)
      redirect_to edit_invoice_path(@invoice), notice: 'Invoice was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @invoice = current_account.invoices.find(params[:id])
      @services = current_account.services

      @services.update_all({invoice_id: nil}, {id: @invoice.services})
      @invoice.destroy

      redirect_to invoices_path, alert: 'Invoice was successfully deleted. Services on invoice are ready to be
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
      current_account.update_attributes(params[:account])

      redirect_to edit_invoice_path(@invoice), notice: "Account was successfully updated for all current and future
invoices for #{current_account.name} Account."
    end
  end

private

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    params.require(:invoice).permit(:established_at, :sales_tax)
  end

  def require_no_payments
    @invoice = current_account.invoices.find(params[:id])
    redirect_to @invoice if @invoice.payments.any?
  end
end
