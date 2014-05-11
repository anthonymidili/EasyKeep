class InventoryItem < ActiveRecord::Base
  attr_accessible :company_id, :description, :item, :serial_number, :unit_amount, :tag_list

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :skills, :interests

  belongs_to :company
end
