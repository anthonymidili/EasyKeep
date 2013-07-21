class WelcomeController < ApplicationController
  def home
    if user_signed_in?
      if current_user.company.nil?
        redirect_to new_company_path
      elsif current_user.account
        @account = current_user.account
        redirect_to account_path(@account)
      else
        @company = current_user.company
        redirect_to company_path(@company)
      end
    end
  end
end
