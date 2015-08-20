class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def require_owner!
    redirect_to root_path unless user_signed_in? && current_user.is_owner?
  end

  def require_admin!
    redirect_to root_path unless user_signed_in? && current_user.is_admin?
  end

  def current_company
    @current_company ||= current_user.company if user_signed_in?
  end; helper_method :current_company

  # The current_account_id is set to the current_account the admin is viewing.
  # Find the current_account by id so if the account is not found it returns nil.
  def current_account
    @current_account ||=
        if current_user.is_admin?
          set_current_account_id
          current_company.accounts.find_by(id: cookies[:current_account])
        else
          current_user.account
        end
  end; helper_method :current_account

  def active_date
    @active_date ||=
        set_active_date_cookie if params[:date]
        (cookies[:active_date] || Date.current).to_date
  end; helper_method :active_date

  def view_by
    @view_by ||=
        set_view_by_cookie if params[:view_by]
        (cookies[:view_by] || :year).to_sym
  end; helper_method :view_by

  def view_quarter
    @view_quarter ||=
        set_view_quarter_cookie if params[:view_quarter]
        (cookies[:view_quarter] || 1).to_i
  end; helper_method :view_quarter

protected

  # If on the accounts_controller or an :account_id is passed in the params by an admin,
  # the current_account cookie will be updated for the current_account.
  # If going to a controller action outside of the accounts controller before the current_account cookie is set,
  # you will need to pass the :account_id as a param in your link.
  def set_current_account_id
    @set_current_account_id ||=
        if params[:controller] == 'accounts' && params[:id]
          cookies[:current_account] = params[:id]
        elsif params[:account_id]
          cookies[:current_account] = params[:account_id]
        end
  end

  def set_active_date_cookie
    @set_active_date_cookie ||=
        cookies[:active_date] =
            Date.new(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i)
  end

  def set_view_by_cookie
    @set_view_by_cookie ||=
        cookies[:view_by] = params[:view_by].to_sym
  end

  def set_view_quarter_cookie
    @set_view_quarter_cookie ||=
        cookies[:view_quarter] = params[:view_quarter]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:invite) << :name
  end
end
