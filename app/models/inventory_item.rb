class InventoryItem < ActiveRecord::Base
  attr_accessible :company_id, :description, :item, :serial_number, :unit_amount, :tag_list

  before_validation { |inventory_item| inventory_item.unit_amount = 0 if inventory_item.unit_amount.blank? }

  belongs_to :company

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :item, presence: true
  validates :unit_amount, numericality: true

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      company.tags.where(name: n.strip).first_or_create!
    end
  end
end
