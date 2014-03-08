class AccountsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin!, except: [:show, :edit, :update]
  before_filter :set_current_account_id
  before_filter :authenticate_account!, only: [:show, :edit, :update]

  def index
    @accounts = current_company.accounts.page(params[:page]).per(10)
  end

  def show
    @account = current_account
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
    @account = current_account
  end

  def update
    @account = current_account
    @account.user.skip_validation = true

    if @account.update_attributes(params[:account])
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @account = current_account
    @account.user.destroy
    redirect_to accounts_url, alert: 'Account and all account information was successfully deleted.'
  end

  def invite_customer
    @account = current_account
    @account.user.invite!(current_user)  # current user is optional to set the invited_by attribute
    redirect_to account_path(@account), notice: 'Successfully sent invitation.'
  end

private

  def authenticate_account!
    unless current_user.is_admin? || current_account && current_user.account.id == current_account.id
      redirect_to account_path(current_user.account)
    end
  end
end
