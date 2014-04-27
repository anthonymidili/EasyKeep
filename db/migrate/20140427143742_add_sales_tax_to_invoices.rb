class AddSalesTaxToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :tax_percentage, :integer, default: 7
  end
end
