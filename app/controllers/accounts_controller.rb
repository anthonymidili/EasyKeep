class AccountsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin, except: [:show, :edit, :update]
  before_filter :load_and_authorize_account, only: [:show, :edit, :update]

  def index
    @accounts = current_company.accounts
  end

  def show
    @services = @account.services
    @service = @account.services.build
    @service.performed_on ||= Date.current
  end

  def new
    @account = current_company.accounts.build
    @account.build_user
  end

  def create
    @account = current_company.accounts.build(params[:account])
    @account.user.company_id = current_company.id
    @account.user.skip_validation = true

    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    @account.user.skip_validation = true

    if @account.update_attributes(params[:account])
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @account = current_company.accounts.find(params[:id])
    @account.user.destroy
    redirect_to accounts_url, alert: 'Account and all account information was successfully deleted.'
  end

private

  def require_admin
    redirect_to account_path(current_user.account) unless current_user.is_admin?
  end

  def load_and_authorize_account
    @account = if current_user.is_admin?
                 current_company.accounts.find(params[:id])
               elsif current_user.account.to_param == params[:id]
                 current_user.account
               else
                 redirect_to account_path(current_user.account)
               end
  end
end
