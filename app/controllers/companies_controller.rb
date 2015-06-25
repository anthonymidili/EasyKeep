class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_owner!, only: [:edit, :update, :destroy, :delete_user]
  before_action :require_admin!, except: [:edit, :update, :destroy, :delete_user, :about]
  before_action :only_one_company, only: [:new, :create]
  before_action :set_view_quarter_cookie, only: [:income_report]

  def show
    @company = current_company
  end

  def new
    @company = current_user.build_company
  end

  def create
    @company = current_user.build_company(company_params)

    if @company.save && current_user.save
      redirect_to dashboard_path, notice: 'Company was successfully created.'
    else
      render :new
    end
  end

  def edit
    @company = current_company
    @invoice = current_company.invoices.find_by_id(params[:invoice_id])
  end

  def update
    @company = current_company
    @invoice = current_company.invoices.find_by_id(params[:invoice_id])

    if @company.update_attributes(company_params)
      redirect_company_or_invoice
    else
      render :edit
    end
  end

  def destroy
    @company = current_company
    @company.destroy
    redirect_to new_company_path
  end

  def income_report
    @accounts = current_company.accounts.includes(company: :invoices)
  end

  def delete_user
    @user = current_company.users.find(params[:id])
    @user.destroy
    redirect_to company_path
  end

  def search_invoices
    @invoices = current_company.invoices.order('id DESC').limit(100).page(params[:page]).per(20).includes(account: :user)
    @invoice = current_company.invoices.find_by_number(params[:search])

    found_invoice
  end

  def about
  end

private

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:address_1, :address_2, :city, :name, :fax, :phone, :state, :zip, :established_on,
                                    :license_number, :service_provided, :service_summery, :website, :logo,
                                    :remote_logo_url, :remove_logo, :logo_cache, :sales_tax)
  end

  def only_one_company
    redirect_to edit_company_path if current_company
  end

  def set_view_quarter_cookie
    @set_view_quarter_cookie ||=
        cookies[:view_quarter] = params[:view_quarter] if params[:view_quarter]
  end

  def found_invoice
    if @invoice
      redirect_to invoice_path(@invoice, account_id: @invoice.account_id),
                  notice: 'Here is the Invoice you requested.'
    elsif params[:search]
      flash[:alert] = "Could not find Invoice# #{params[:search]}."
      render :search_invoices
    end
  end

  def redirect_company_or_invoice
    if @invoice
      redirect_to edit_invoice_path(@invoice), notice: 'Company was successfully updated.'
    else
      redirect_to edit_company_path, notice: 'Company was successfully updated.'
    end
  end
end
