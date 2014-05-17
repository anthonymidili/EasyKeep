class RenameInventoryToInventoryItem < ActiveRecord::Migration
  def change
    rename_table :inventories, :inventory_items
  end
end
