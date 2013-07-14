class SetAccountEmailNullToAccounts < ActiveRecord::Migration
  def up
    change_column_default(:accounts, :email, nil)
  end

  def down
    raise "NO BACKING DOWN"
  end
end
