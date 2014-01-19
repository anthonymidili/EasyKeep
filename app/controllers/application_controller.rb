class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_company
    current_user.company if user_signed_in?
  end

  # The current_account_id needs to be set for any link leaving the accounts/index action for admins to view and edit
  # the correct account information.
  def current_account
    if current_user.is_admin?
      Account.find(current_user.current_account_id)
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
