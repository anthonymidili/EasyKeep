class AddPrePostFixToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :prefix, :string
    add_column :accounts, :postfix, :string
    add_column :accounts, :divider, :string
  end
end
