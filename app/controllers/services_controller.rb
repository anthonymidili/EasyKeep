class ServicesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin!

  def create
    @services = current_account.services
    @service = current_account.services.build(params[:service])
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
      redirect_to current_account, notice: 'Service was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @service = current_account.services.find(params[:id])
    @service.destroy

    redirect_to current_account, alert: 'Service history item successfully deleted.'
  end

  def invoice
    ActiveRecord::Base.transaction do
      @invoice = current_account.invoices.new(params[:invoice])
      @invoice.established_at = Date.current

      if @invoice.save
        @services = current_account.services
        @services.update_all({invoice_id: @invoice.id}, {id: params[:service_ids]})

        redirect_to invoice_path(@invoice)
      else
        redirect_to current_account, alert: 'There was a problem creating a new invoice. Please try again.'
      end
    end
  end
end
