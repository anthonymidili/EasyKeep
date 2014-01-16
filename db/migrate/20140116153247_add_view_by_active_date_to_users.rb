class AddViewByActiveDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :view_by, :string
    add_column :users, :active_date, :date
  end
end
