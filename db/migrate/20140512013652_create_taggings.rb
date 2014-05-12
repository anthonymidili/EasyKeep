class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.belongs_to :tag
      t.belongs_to :inventory_item
      t.integer :company_id

      t.timestamps
    end
    add_index :taggings, :tag_id
    add_index :taggings, :inventory_item_id
  end
end
