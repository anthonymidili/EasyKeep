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

private

  def set_cookies
    cookies[:active_date] = Date.current if cookies[:active_date].nil?
  end
end
