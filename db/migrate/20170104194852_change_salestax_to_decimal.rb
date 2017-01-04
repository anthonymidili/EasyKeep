class ChangeSalestaxToDecimal < ActiveRecord::Migration[5.0]
  def change
    change_column :companies, :sales_tax, :decimal, precision: 7, scale: 4, default: 0
    change_column :invoices, :sales_tax, :decimal, precision: 7, scale: 4
  end
end
