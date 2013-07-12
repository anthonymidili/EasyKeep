class AddNameAndAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :is_admin, :boolean
  end
end
