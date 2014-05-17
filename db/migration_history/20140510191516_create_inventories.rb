class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :item
      t.integer :unit_amount, default: 0
      t.string :serial_number
      t.string :description
      t.integer :company_id

      t.timestamps
    end
  end
end
