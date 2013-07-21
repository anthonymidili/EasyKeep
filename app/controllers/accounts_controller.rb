class AccountsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @accounts = current_company.accounts.all
  end

  def show
    @account = current_company.accounts.find(params[:id])
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
    @account = current_company.accounts.find(params[:id])
  end

  def update
    @account = current_company.accounts.find(params[:id])
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
end
