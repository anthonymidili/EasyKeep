class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_company
    current_user.company if user_signed_in?
  end

  def active_date
    if params[:date]
      current_user.active_date = Date.new(params[:date][:year].to_i,
                                          params[:date][:month].to_i,
                                          params[:date][:day].to_i)
      current_user.save

      current_user.active_date
    else
      current_user.active_date || Date.current
    end
  end; helper_method :active_date

  def view_by
    if params[:view_by]
      current_user.view_by = params[:view_by]
      current_user.save

      current_user.view_by.to_sym
    else
      current_user.view_by ? current_user.view_by.to_sym : :month
    end
  end; helper_method :view_by
end
