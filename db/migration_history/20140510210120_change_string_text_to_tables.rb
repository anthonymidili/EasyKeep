class ChangeStringTextToTables < ActiveRecord::Migration
  def change
    change_column :inventory_items, :description, :text
    change_column :payments, :memo, :text
  end
end
