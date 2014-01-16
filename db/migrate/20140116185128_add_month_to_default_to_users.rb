class AddMonthToDefaultToUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.update_attribute(:view_by, 'month')
    end
  end
end
