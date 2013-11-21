class ServicesController < ApplicationController
  before_filter :set_account

  def index
    @services = @account.services
  end

  def show
    @service = @account.services.find(params[:id])
  end

  def new
    @service = @account.services.new
  end

  def edit
    @service = @account.services.find(params[:id])
  end

  def create
    @service = @account.services.new(params[:service])

    if @service.save
      redirect_to [@account, @service], notice: 'Service was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @service = @account.services.find(params[:id])

    if @service.update_attributes(params[:service])
      redirect_to [@account, @service], notice: 'Service was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @service = @account.services.find(params[:id])
    @service.destroy

    redirect_to account_services_url
  end

private

  def set_account
    @account = current_company.accounts.find(params[:account_id])
  end

end
