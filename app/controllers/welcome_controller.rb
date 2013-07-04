class WelcomeController < ApplicationController
  def home
    redirect_to companies_path if admin_signed_in?
  end
end
