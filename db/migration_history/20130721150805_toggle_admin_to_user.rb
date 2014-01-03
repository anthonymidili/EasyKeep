class ToggleAdminToUser < ActiveRecord::Migration
  user = User.find_by_email('tonywinslow@yahoo.com')
  user.update_attribute(:is_admin, true)
end
