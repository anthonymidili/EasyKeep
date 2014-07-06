class Users::RegistrationsController < Devise::RegistrationsController
  before_action :require_owner!, only: [:destroy]

  def new
    build_resource({})
    self.resource.build_company
    respond_with self.resource
  end

  def destroy
    resource.company.destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

protected

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
    self.resource.is_owner = true
    self.resource.is_admin = true
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation,
                                                            company_attributes: [:id, :name]) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :current_password, :password,
                                                                   :password_confirmation) }
  end
end
