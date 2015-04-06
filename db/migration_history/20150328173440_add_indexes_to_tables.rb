class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index :accounts, :company_id
    add_index :accounts, :user_id
    add_index :inventory_items, :company_id
    add_index :invoices, :account_id
    add_index :invoices, :company_id
    add_index :payments, :invoice_id
    add_index :payments, :account_id
    add_index :payments, :company_id
    add_index :services, :invoice_id
    add_index :services, :account_id
    add_index :services, :company_id
    add_index :tags, :company_id
    add_index :users, :company_id
  end
end
