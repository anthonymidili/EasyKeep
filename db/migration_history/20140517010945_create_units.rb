class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.string :company_id

      t.timestamps
    end

    change_column :inventory_items, :unit_amount, :decimal, precision: 19, scale: 3
    add_column :inventory_items, :unit_type, :string
  end
end
