class DeveloperController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_developer!

  def dashboard
    @users = Kaminari.paginate_array(admins_or_all_users.sort_by(&:company_id)).page(params[:page]).per(10)
  end

private

  def authenticate_developer!
    redirect_to root_path unless current_user.email == ENV['DEVELOPER_EMAIL']
  end

  def admins_or_all_users
    params[:all_users] ? User.all : User.by_admin_user
  end
end
