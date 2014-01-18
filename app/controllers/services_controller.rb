class ServicesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin, except: [:show]
  before_filter :set_and_authenticate_account

  def show
    @service = @account.services.find(params[:id])
  end

  def edit
    @service = @account.services.find(params[:id])
  end

  def create
    @services = @account.services
    @service = @account.services.new(params[:service])

    if @service.save
      redirect_to @account, notice: 'Service was successfully created.'
    else
      render 'accounts/show'
    end
  end

  def update
    @service = @account.services.find(params[:id])

    if @service.update_attributes(params[:service])
      redirect_to @account, notice: 'Service was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @service = @account.services.find(params[:id])
    @service.destroy

    redirect_to @account, alert: 'Service history item successfully deleted.'
  end

  def invoice
    ActiveRecord::Base.transaction do
      @invoice = @account.invoices.new(params[:invoice])

      if @invoice.save
        @services = @account.services
        @services.update_all({invoice_id: @invoice.id}, {id: params[:service_ids]})

        redirect_to invoice_path(@invoice, account_id: @account.id)
      else
        redirect_to @account, alert: 'There was a problem creating a new invoice. Please try again.'
      end
    end
  end

private

  def require_admin
    redirect_to account_path(current_user.account) unless current_user.is_admin?
  end

  def set_and_authenticate_account
    @account = current_account
    redirect_to account_path(@account) unless current_user.is_admin? || @account.to_param == params[:account_id]
  end
end
