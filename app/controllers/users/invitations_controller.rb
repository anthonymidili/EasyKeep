class Users::InvitationsController < Devise::InvitationsController
  before_filter :require_admin!, except: [:edit, :update]
  prepend_before_filter :authenticate_inviter!, :only => [:new, :create]
  prepend_before_filter :has_invitations_left?, :only => [:create]
  prepend_before_filter :require_no_authentication, :only => [:edit, :update, :destroy]
  prepend_before_filter :resource_from_invitation_token, :only => [:edit, :destroy]
  helper_method :after_sign_in_path_for

  def create
    self.resource = resource_class.invite!(invite_params, current_inviter) do |invitable|
      invitable.company_id = current_user.company_id
      invitable.is_admin = true
      invitable.save
    end

    if resource.errors.empty?
      set_flash_message :notice, :send_instructions, :email => self.resource.email
      respond_with resource, :location => after_invite_path_for(resource)
    else
      respond_with_navigational(resource) { render :new }
    end
  end

  def invite_user
    @account = current_company.accounts.find(params[:account_id])
    @account.user.invite!(current_user)  # current user is optional to set the invited_by attribute
    redirect_to account_path(@account), notice: 'Successfully sent invitation.'
  end
end
