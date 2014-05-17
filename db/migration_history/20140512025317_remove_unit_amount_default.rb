class RemoveUnitAmountDefault < ActiveRecord::Migration
  def change
    remove_column :inventory_items, :unit_amount
    add_column :inventory_items, :unit_amount, :integer
  end
end
