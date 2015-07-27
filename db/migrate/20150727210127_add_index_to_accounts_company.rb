class AddIndexToAccountsCompany < ActiveRecord::Migration
  def change
    add_index :accounts, [:company_id, :name], unique: true
  end
end
