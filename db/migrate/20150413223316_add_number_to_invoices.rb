class AddNumberToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :number, :integer

    Invoice.all.each do |invoice|
      invoice.update_attribute(:number, invoice.id)
    end
  end
end
