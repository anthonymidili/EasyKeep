class RenameColumnItemsToInventoryItems < ActiveRecord::Migration
  def change
    rename_column :inventory_items, :item, :description
    rename_column :inventory_items, :unit_amount, :quantity
  end
end
