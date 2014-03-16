class Users::RegistrationsController < Devise::RegistrationsController

protected

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
    self.resource.is_owner = true
    self.resource.is_admin = true
  end

end