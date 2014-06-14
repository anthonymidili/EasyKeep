class DeveloperController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_developer!

  def dashboard
    @admin_users = Kaminari.paginate_array(User.by_admin_user.sort_by(&:company_id)).page(params[:page]).per(10)
  end

private

  def authenticate_developer!
    redirect_to root_path unless current_user.email == ENV['DEVELOPER_EMAIL']
  end
end
