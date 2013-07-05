class WelcomeController < ApplicationController
  def home
    if admin_signed_in?
      if current_admin.company.nil?
        redirect_to new_company_path
      else
        @company = current_admin.company
        redirect_to company_path(@company)
      end
    end
  end
end
