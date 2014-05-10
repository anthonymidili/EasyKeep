class InventoryItem < ActiveRecord::Base
  attr_accessible :company_id, :description, :item, :serial_number, :unit_amount

  belongs_to :company
end
