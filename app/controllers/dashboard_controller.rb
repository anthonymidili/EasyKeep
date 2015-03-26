class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_developer!, only: [:developer]
  before_action :load_if_current_account, only: [:home]

  def home
    @accounts = current_company.accounts.by_recent_activity.with_limit
    @service = current_company.services.build
    @service.performed_on ||= Date.current
  end

  def developer
    @users = Kaminari.paginate_array(admins_or_all_users.sort_by(&:company_id)).page(params[:page]).per(10)
  end

private

  def authenticate_developer!
    redirect_to root_path unless current_user.email == ENV['DEVELOPER_EMAIL']
  end

  def admins_or_all_users
    params[:all_users] ? User.all : User.by_admin_user
  end

  def load_if_current_account
    if current_account
      @account = current_account
      @services = current_account.services
      @invoices = current_account.invoices.by_outstanding
    end
  end
end
