class RemoveCurrentAccountIdToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :current_account_id
  end
end
