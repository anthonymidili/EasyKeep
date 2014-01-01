class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_company
    current_user.company if user_signed_in?
  end

  def active_date
    @active_date = begin
      cookies[:active_date] = Date.new(params[:date][:year].to_i, params[:date][:month].to_i,params[:date][:day].to_i)
    rescue
      if cookies[:active_date].nil?
        cookies[:active_date] = Date.current
      else
        cookies[:active_date].to_date
      end
    end
  end; helper_method :active_date
end
