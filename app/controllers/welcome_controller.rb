class WelcomeController < ApplicationController
  def home
    if user_signed_in?
      if current_user.company.nil?
        redirect_to new_company_path
      elsif current_user.account
        @account = current_user.account
        redirect_to account_path(@account)
      elsif current_user.is_admin?
        redirect_to accounts_path
      end
    end
  end
end
