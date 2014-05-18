class DropTableUnits < ActiveRecord::Migration
  def change
    drop_table :units
    remove_column :inventory_items, :description
    remove_column :inventory_items, :unit_type
  end
end
