class AccountsController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @accounts = current_admin.company.accounts.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts }
    end
  end

  def show
    @account = current_admin.company.accounts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
  end

  def new
    @account = current_admin.company.accounts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
  end

  def edit
    @account = current_admin.company.accounts.find(params[:id])
  end

  def create
    @account = current_admin.company.accounts.new(params[:account])

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render json: @account, status: :created, location: @account }
      else
        format.html { render action: 'new' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @account = current_admin.company.accounts.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account = current_admin.company.accounts.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end
end
