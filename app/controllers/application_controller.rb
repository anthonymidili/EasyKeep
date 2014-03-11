class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_admin!
    redirect_to root_path unless current_user.is_admin?
  end

  def require_owner!
    redirect_to root_path unless current_user.is_owner?
  end

  def current_company
    @current_company ||= current_user.company if user_signed_in?
  end; helper_method :current_company

  # If on the accounts_controller or an :account_id is passed in the params by an admin,
  # the current_account cookie will be updated for the current_account.
  # If going to a controller action outside of the accounts controller before the current_account cookie is set,
  # you will need to pass the :account_id as a param in your link.
  def set_current_account_id
    @set_current_account_id ||=
        if params[:controller] == 'accounts' && params[:id]
          cookies[:current_account] = params[:id]
        elsif current_user.is_admin? && params[:account_id]
          cookies[:current_account] = params[:account_id]
        end
  end

  # The current_account_id is set to the current_account the user is viewing.
  # Find the current_account by id so if the account is not found it returns nil.
  def current_account
    @current_account ||= current_company.accounts.find_by_id(cookies[:current_account]) if user_signed_in?
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

  def view_quarter
    @view_quarter ||=
          cookies[:view_quarter] ? cookies[:view_quarter].to_i : 1
  end; helper_method :view_quarter
end
