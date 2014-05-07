class DeveloperController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_developer!

  def dashboard
    @users = User.all
    @owners = User.where(is_owner: true)
  end

private

  def authenticate_developer!
    redirect_to root_path unless current_user.email == ENV['DEVELOPER_EMAIL']
  end
end
