class ServicesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin
  before_filter :set_account

  def edit
    @service = @account.services.find(params[:id])
  end

  def create
    @services = @account.services.all
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

    redirect_to @account
  end

private

  def require_admin
    redirect_to account_path(current_user.account) unless current_user.is_admin?
  end

  def set_account
    @account = current_company.accounts.find(params[:account_id])
  end

end
