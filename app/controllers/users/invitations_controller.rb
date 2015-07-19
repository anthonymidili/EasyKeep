class Users::InvitationsController < Devise::InvitationsController
  before_action :require_owner!, only: [:new, :create]

  def create
    self.resource = invite_resource

    if resource.errors.empty?
      redirect_to company_path, notice: 'Email to invite a new admin has been successfully sent.'
    else
      super
    end
  end

private

  # this is called when creating invitation
  # should return an instance of resource class
  # modified to set invited admin user variables
  def invite_resource
    resource_class.invite!(invite_params, current_inviter) do |invitable|
      invitable.company_id = current_user.company_id
      invitable.is_admin = true
      invitable.require_email = true
      invitable.save!
    end
  end
end
