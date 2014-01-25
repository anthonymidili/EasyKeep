class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_admin!
    redirect_to account_path(current_user.account) unless current_user.is_admin?
  end

  def current_company
    @current_company ||= current_user.company if user_signed_in?
  end; helper_method :current_company

  # If an :account_id is passed in the params by an admin, the current_account_id will be updated for the current_user.
  # If going to a controller action outside of the accounts controller before the current_account_id is set,
  # you will need to pass the :account_id as a param in your link.
  # Use this on any controller that belongs_to an account model.
  def set_nested_current_account_id
    if current_user.is_admin? && params[:account_id]
      current_user.current_account_id = params[:account_id]
      current_user.save
    end
  end

  # The current_account_id is set to the current_account the user is viewing.
  # Find the current_account by id so if the account is not found it returns nil.
  def current_account
    @current_account ||= current_company.accounts.find_by_id(current_user.current_account_id) if user_signed_in?
  end; helper_method :current_account

  def active_date
    @active_date ||=
        if params[:date]
          cookies[:active_date] = Date.new(params[:date][:year].to_i,
                                           params[:date][:month].to_i,
                                           params[:date][:day].to_i)
        else
          cookies[:active_date] ? cookies[:active_date].to_date : Date.current
        end
  end; helper_method :active_date

  def view_by
    @view_by ||=
        if params[:view_by]
          cookies[:view_by] = params[:view_by].to_sym
        else
          cookies[:view_by] ? cookies[:view_by].to_sym : :month
        end
  end; helper_method :view_by
end
