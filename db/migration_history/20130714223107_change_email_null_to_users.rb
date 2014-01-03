class ChangeEmailNullToUsers < ActiveRecord::Migration
  def up
    change_column_null(:users, :email, true)
    change_column_default(:users, :email, nil)
  end

end
