class AddCurrentAccountIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_account_id, :integer
  end
end
