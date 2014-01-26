class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :type
      t.date :received_on
      t.decimal :amount, :precision => 19, :scale => 2
      t.integer :invoice_id

      t.timestamps
    end
  end
end
