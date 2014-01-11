class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :account_id

      t.timestamps
    end

    add_column :services, :invoice_id, :integer
    change_column :services, :price, :decimal, :precision => 19, :scale => 4
  end
end
