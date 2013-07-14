class ChangeEmailNullToAccounts < ActiveRecord::Migration
  def up
    change_column_null(:accounts, :email, true, nil)

    Account.where(email: "").each do |account|
      account.update_attribute(:email, nil)
    end
  end

  def down
    raise "NO BACKING DOWN"
  end
end
