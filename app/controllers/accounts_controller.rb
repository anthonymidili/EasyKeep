class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner!, only: [:destroy]
  before_action :require_admin!, except: [:show, :edit, :update, :destroy]
  before_action :set_current_account_id
  before_action :authenticate_account!, only: [:show, :edit, :update]

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
    @account = current_company.accounts.build(account_params)
    @account.user.company_id = current_company.id
    @account.user.skip_validation = true

    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  def edit
    @account = current_account
  end

  def update
    @account = current_account
    @account.user.skip_validation = true

    if @account.update_attributes(account_params)
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @account = current_account
    @account.destroy
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:address_1, :address_2, :city, :fax, :name, :phone, :state, :zip,
                                    :uses_account_name, :uses_contact_name,
                                    user_attributes: [:id, :email, :password, :password_confirmation, :remember_me, :name])
  end
end
