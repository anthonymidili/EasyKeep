class Payment < ActiveRecord::Base
  attr_accessible :amount, :received_on, :type

  belongs_to :invoice

  validates :amount, presence: true
end
