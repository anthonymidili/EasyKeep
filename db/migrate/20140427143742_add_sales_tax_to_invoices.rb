class AddSalesTaxToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :sales_tax, :integer, default: 7
  end
end
