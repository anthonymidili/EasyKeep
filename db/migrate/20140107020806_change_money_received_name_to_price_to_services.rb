class ChangeMoneyReceivedNameToPriceToServices < ActiveRecord::Migration
  def change
    rename_column :services, :money_received, :price
  end
end
