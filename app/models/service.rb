class Service < ActiveRecord::Base
  before_save { |service| service.money_received = 0 if service.money_received.blank? }

  attr_accessible :money_received, :note, :performed_on

  belongs_to :account

  default_scope order: 'performed_on DESC'

  validates :performed_on, presence: true
end
