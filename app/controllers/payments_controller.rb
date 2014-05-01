class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin!
  before_filter :load_invoice

  def new
    @payment = @invoice.payments.build
    @payment.received_on ||= Date.current
  end

  def create
    @payment = @invoice.payments.build(params[:payment])
    @payment.company_id = current_company.id
    @payment.account_id = current_account.id
    @payments = @invoice.payments
    @services = @invoice.services

    if @payment.save
      redirect_to @invoice, notice: 'Payment was successfully created. INVOICES can only be EDITED or DELETED when no payments are applied!'
    else
      render 'payments/_new'
    end
  end

  def edit
    @payment = @invoice.payments.find(params[:id])
  end

  def update
    @payment = @invoice.payments.find(params[:id])

    if @payment.update_attributes(params[:payment])
      redirect_to @invoice, notice: 'Payment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @payment = @invoice.payments.find(params[:id])
    @payment.destroy

    redirect_to @invoice, alert: 'Payment history item successfully deleted.'
  end

private

  def load_invoice
    @invoice = current_account.invoices.find(params[:invoice_id])
  end
end
