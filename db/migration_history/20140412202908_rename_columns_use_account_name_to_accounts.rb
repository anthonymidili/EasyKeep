class RenameColumnsUseAccountNameToAccounts < ActiveRecord::Migration
  def change
    rename_column :accounts, :use_account_name, :uses_account_name
    rename_column :accounts, :use_contact_name, :uses_contact_name
  end
end
