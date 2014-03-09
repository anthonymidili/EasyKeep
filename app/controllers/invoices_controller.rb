class InvoicesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin!, except: [:show, :index]
  before_filter :set_current_account_id, only: [:index, :show]

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

    if @invoice.update_attributes(params[:invoice])
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

      redirect_to invoices_path, alert: 'Invoice was successfully deleted.'
    end
  end

  def add_services
    ActiveRecord::Base.transaction do
      @invoice = current_account.invoices.find(params[:id])
      @services = current_account.services

      @services.update_all({invoice_id: @invoice.id}, {id: params[:service_ids]})

      redirect_to edit_invoice_path(@invoice)
    end
  end

  def remove_services
    ActiveRecord::Base.transaction do
      @invoice = current_account.invoices.find(params[:id])

      @invoice.services.update_all({invoice_id: nil}, {id: params[:service_ids]})

      redirect_to edit_invoice_path(@invoice)
    end
  end

  def invoice_ready
    @invoice = current_account.invoices.find(params[:id])
    UserMailer.invoice_ready_notice(@invoice).deliver

    redirect_to @invoice, notice: "Email has been successfully sent to #{@invoice.account.user.name}."
  end
end
