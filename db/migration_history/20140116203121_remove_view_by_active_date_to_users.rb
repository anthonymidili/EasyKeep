class RemoveViewByActiveDateToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :view_by
    remove_column :users, :active_date
  end
end
