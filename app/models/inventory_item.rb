class InventoryItem < ActiveRecord::Base
  attr_accessible :company_id, :description, :serial_number, :quantity, :tag_list,
                  :new_unit_type

  before_validation { |inventory_item| inventory_item.quantity = 0 if inventory_item.quantity.blank? }

  belongs_to :company

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :description, presence: true
  validates :quantity, numericality: true

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      company.tags.where(name: n.strip.downcase).first_or_create!
    end
  end
end
