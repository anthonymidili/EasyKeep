class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner!, only: [:destroy]
  before_action :require_admin!, except: [:edit, :update, :destroy]
  before_action :authenticate_account!, except: [:index, :new, :create]
  before_action :load_account, only: [:show, :edit, :update, :destroy, :invite_customer]

  def index
    @accounts = current_company.accounts.by_name.page(params[:page]).per(10).includes(:invoices, :user)
  end

  def show
    @service = @account.services.build
    @service.performed_on ||= Date.current
    @services = @account.services.includes(:invoice)
    @invoice = @account.invoices.build
    @invoice.established_at ||= Date.current
    @invoice.sales_tax ||= current_company.sales_tax
    @invoices = @account.invoices.includes(:payments, :account).by_outstanding
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
    @invoice = current_company.invoices.find_by(id: params[:invoice_id])
  end

  def update
    @account.user.skip_validation = true
    @invoice = current_company.invoices.find_by(id: params[:invoice_id])

    if @account.update_attributes(account_params)
      redirect_account_or_invoice
    else
      render :edit
    end
  end

  def destroy
    @account.destroy
    redirect_to accounts_url, alert: 'Account and all account information was successfully deleted.'
  end

  def invite_customer
    @account.user.invite!(current_user)  # current user is optional to set the invited_by attribute
    redirect_to account_path(@account), notice: 'Successfully sent invitation.'
  end

private

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:address_1, :address_2, :city, :fax, :name, :phone, :state, :zip,
                                    :uses_account_name, :uses_contact_name, :prefix, :postfix, :divider,
                                    user_attributes: [:id, :email, :password, :password_confirmation, :remember_me, :name])
  end

  def authenticate_account!
    redirect_to root_path if current_account.nil?
  end

  def load_account
    @account = current_account
  end

  def redirect_account_or_invoice
    if @invoice
      redirect_to edit_invoice_path(@invoice), notice: 'Account was successfully updated.'
    elsif current_user.is_admin?
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      redirect_to root_path, notice: 'Your account was successfully updated.'
    end
  end
end
