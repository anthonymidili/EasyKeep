class AddDatedForToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :invoice_date, :date

    Invoice.all.each do |invoice|
      invoice.update_attribute(:invoice_date, invoice.created_at.to_date)
    end
  end
end
