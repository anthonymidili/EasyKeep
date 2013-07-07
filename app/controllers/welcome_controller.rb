class WelcomeController < ApplicationController
  def home
    if user_signed_in?
      if current_user.company.nil?
        redirect_to new_company_path
      else
        @company = current_user.company
        redirect_to company_path(@company)
      end
    end
  end
end
