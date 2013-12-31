class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_company
    current_user.company if user_signed_in?
  end

  def active_date
    @active_date = begin
      Date.new(params[:date][:year].to_i, params[:date][:month].to_i,params[:date][:day].to_i)
    rescue
      Date.current
    end
  end; helper_method :active_date
end
