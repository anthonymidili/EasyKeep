class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_company
    current_user.company if user_signed_in?
  end
end
