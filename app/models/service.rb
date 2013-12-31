class Service < ActiveRecord::Base
  before_save { |service| service.money_received = 0 if service.money_received.blank? }

  attr_accessible :money_received, :note, :performed_on

  belongs_to :account

  validates :performed_on,
            format: { with: /^(?<year>\d{4})\-(?<month>\d{1,2})\-(?<day>\d{1,2})$/,
                      message: 'date must be formatted correctly (yyyy-mm-dd)' }

  default_scope order: 'performed_on DESC'

  scope :by_year, -> active_date {
    date = active_date
    where("performed_on >= ? AND performed_on <= ?", date.beginning_of_year, date.end_of_year)
  }
end
