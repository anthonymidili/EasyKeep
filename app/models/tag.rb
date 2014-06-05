class Tag < ActiveRecord::Base
  belongs_to :company

  has_many :taggings, dependent: :destroy
  has_many :inventory_items, through: :taggings
end
