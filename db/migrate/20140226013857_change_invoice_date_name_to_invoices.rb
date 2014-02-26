class ChangeInvoiceDateNameToInvoices < ActiveRecord::Migration
  def change
    rename_column :invoices, :invoice_date, :established_at
  end
end
