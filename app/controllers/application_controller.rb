class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_company
    @current_company ||= current_user.company if user_signed_in?
  end

  # If an :account_id is passed in the params, the current_account_id will be updated for the current_user.
  # If going to a controller action outside of the accounts controller before the current_account_id is set,
  # you will need to pass the :account_id as a param in your link.
  # Use this on any controller that belongs_to an account model.
  def set_nested_current_account_id
    @set_nested_current_account_id ||=
        if params[:account_id]
          current_user.current_account_id = params[:account_id]
          current_user.save
        end
  end

  # The current_account_id is set to the current account the user is viewing.
  # Use this on any controller you need the @account with a before_filter.
  def set_and_authenticate_account
    @set_and_authenticate_account ||=
        @account = current_company.accounts.find(current_user.current_account_id) if user_signed_in?

    unless current_user.is_admin? || current_user.account.id == @account.id
      redirect_to account_path(current_user.account)
    end
  end

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
