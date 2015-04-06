class AddSalesTaxToCompanies < ActiveRecord::Migration
  def up
    add_column :companies, :sales_tax, :integer, default: 0
    change_column_default :invoices, :sales_tax, nil
  end

  def down
    remove_column :companies, :sales_tax
    change_column_default :invoices, :sales_tax, 7
  end
end
