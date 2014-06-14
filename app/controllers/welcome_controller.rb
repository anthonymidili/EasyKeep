class WelcomeController < ApplicationController
  before_action :create_new_company

  def home
    if user_signed_in?
      if  current_user.is_admin?
        redirect_to accounts_path
      else
        redirect_to account_path(current_user.account)
      end
    end
  end

  def about
  end

  def contact_us
  end

  def sitemap
  end

private

  def create_new_company
    redirect_to new_company_path if user_signed_in? && current_user.is_admin? && current_company.nil?
  end
end
