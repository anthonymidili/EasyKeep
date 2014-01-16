class AddDefaultToViewByToUsers < ActiveRecord::Migration
  def change
    change_column :users, :view_by, :string, default: 'month'
  end
end
