class Service < ActiveRecord::Base
  attr_accessible :money_received, :note, :performed_on

  belongs_to :account

  validates :money_received, numericality: true
end
