class DeveloperController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_developer!

  def dashboard
    @users = User.page(params[:page]).per(10)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to developer_dashboard_path, alert: 'User successfully deleted.'
  end

private

  def authenticate_developer!
    redirect_to root_path unless current_user.email == ENV['DEVELOPER_EMAIL']
  end
end
