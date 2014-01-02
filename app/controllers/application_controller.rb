class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_cookies

  def current_company
    current_user.company if user_signed_in?
  end

  def active_date
    if params[:date]
      cookies[:active_date] = Date.new(params[:date][:year].to_i,
                                       params[:date][:month].to_i,
                                       params[:date][:day].to_i)
    else
      cookies[:active_date].to_date
    end
  end; helper_method :active_date

  def view_by
    if params[:view_by]
      cookies[:view_by] = params[:view_by].to_sym
    else
      cookies[:view_by].to_sym
    end
  end; helper_method :view_by

private

  def set_cookies
    cookies[:active_date] = Date.current if cookies[:active_date].nil?
    cookies[:view_by] = :year if cookies[:view_by].nil?
  end
end
