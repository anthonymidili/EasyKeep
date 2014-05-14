class Tag < ActiveRecord::Base
  attr_accessible :name

  belongs_to :company

  has_many :taggings, dependent: :destroy
  has_many :inventory_items, through: :taggings
end
