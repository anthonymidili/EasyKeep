class AddMemoToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :memo, :string
  end
end
