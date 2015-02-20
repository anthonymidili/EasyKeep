class ChangeRecentActivityAtDefault < ActiveRecord::Migration
  def change
    Account.all.each do |account|
      account.update_attribute(:recent_activity_at, Time.now) unless account.recent_activity_at.present?
    end

    change_column :accounts, :recent_activity_at, :datetime, null: false
  end
end
