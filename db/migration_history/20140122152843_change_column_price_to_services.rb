class ChangeColumnPriceToServices < ActiveRecord::Migration
  def change
    rename_column :services, :price, :cost
    change_column :services, :cost, :decimal, precision: 19, scale: 2
  end
end
