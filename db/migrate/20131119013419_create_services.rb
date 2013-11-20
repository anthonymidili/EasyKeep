class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.date :performed_on
      t.decimal :money_received, precision: 10, scale: 2
      t.text :note
      t.integer :account_id

      t.timestamps
    end
  end
end
