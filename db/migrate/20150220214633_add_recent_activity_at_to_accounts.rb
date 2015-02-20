class AddRecentActivityAtToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :recent_activity_at, :datetime
  end
end
