class RenameTypeToPayments < ActiveRecord::Migration
  def change
    rename_column :payments, :type, :transaction_type
  end
end
