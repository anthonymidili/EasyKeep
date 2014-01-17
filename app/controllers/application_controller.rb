class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_company
    current_user.company if user_signed_in?
  end

  def current_account
    if current_user.is_admin?
      if params[:account_id]
        current_company.accounts.find(params[:account_id])
      else
        current_company.accounts.find(params[:id])
      end
    else
      current_user.account
    end
  end

  def active_date
    if params[:date]
      cookies[:active_date] = Date.new(params[:date][:year].to_i,
                                       params[:date][:month].to_i,
                                       params[:date][:day].to_i)
    else
      cookies[:active_date] ? cookies[:active_date].to_date : Date.current
    end
  end; helper_method :active_date

  def view_by
    if params[:view_by]
      cookies[:view_by] = params[:view_by].to_sym
    else
      cookies[:view_by] ? cookies[:view_by].to_sym : :month
    end
  end; helper_method :view_by
end
