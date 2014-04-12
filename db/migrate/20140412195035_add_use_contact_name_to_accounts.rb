class AddUseContactNameToAccounts < ActiveRecord::Migration
  def change
    rename_column :accounts, :is_a_company, :use_account_name
    change_column :accounts, :use_account_name, :boolean, default: true
    add_column :accounts, :use_contact_name, :boolean, default: true
  end
end
