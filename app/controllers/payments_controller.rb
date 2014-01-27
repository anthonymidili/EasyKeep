class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin!
  before_filter :load_invoice

  def index
    @payments = @invoice.payments
  end

  def show
    @payment = @invoice.payments.find(params[:id])
  end

  def new
    @payment = @invoice.payments.build
  end

  def create
    @payment = @invoice.payments.build(params[:payment])

    if @payment.save
      redirect_to @invoice, notice: 'Payment was successfully created.'
    else
      render 'invoices/show'
    end
  end

  def edit
    @payment = @invoice.payments.find(params[:id])
  end

  def update
    @payment = @invoice.payments.find(params[:id])

    if @payment.update_attributes(params[:payment])
      redirect_to invoice_payment_path(@invoice, @payment), notice: 'Payment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @payment = @invoice.payments.find(params[:id])
    @payment.destroy

    redirect_to invoice_payments_path(@invoice)
  end

private

  def load_invoice
    @invoice = current_account.invoices.find(params[:invoice_id])
  end
end
