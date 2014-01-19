class InvoicesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin, except: [:show, :index]
  before_filter :set_nested_current_account_id
  before_filter :set_and_authenticate_account

  def show
    @invoice = @account.invoices.find(params[:id])
    @services = @invoice.services
  end

  def index
    @invoices = @account.invoices.page(params[:page]).per(10)
  end

  def edit
    @invoice = @account.invoices.find(params[:id])
    @services = @account.services
  end

  def destroy
    ActiveRecord::Base.transaction do
      @invoice = @account.invoices.find(params[:id])
      @services = @account.services

      @services.update_all({invoice_id: nil}, {id: @invoice.services})
      @invoice.destroy

      redirect_to invoices_path, alert: 'Invoice was successfully deleted.'
    end
  end

  def add_services
    ActiveRecord::Base.transaction do
      @invoice = @account.invoices.find(params[:id])
      @services = @account.services

      @services.update_all({invoice_id: @invoice.id}, {id: params[:service_ids]})

      redirect_to edit_invoice_path(@invoice)
    end
  end

  def remove_services
    ActiveRecord::Base.transaction do
      @invoice = @account.invoices.find(params[:id])

      @invoice.services.update_all({invoice_id: nil}, {id: params[:service_ids]})

      redirect_to edit_invoice_path(@invoice)
    end
  end

private

  def require_admin
    redirect_to account_path(current_user.account) unless current_user.is_admin?
  end
end
