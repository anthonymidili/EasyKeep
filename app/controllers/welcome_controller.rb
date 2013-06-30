class WelcomeController < ApplicationController
  def home
    redirect_to accounts_path if admin_signed_in?
  end
end
