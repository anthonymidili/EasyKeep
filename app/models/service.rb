class Service < ActiveRecord::Base

  before_validation { |service| service.cost = 0 if service.cost.blank? }

  belongs_to :account
  belongs_to :invoice

  validates :cost, numericality: true
  validates :performed_on,
            format: { with: /^(?<year>\d{4})\-(?<month>\d{1,2})\-(?<day>\d{1,2})$/,
                      message: 'date must be formatted correctly (yyyy-mm-dd)' }

  default_scope { order('performed_on DESC') }

  scope :by_year, -> active_date {
    where(performed_on: active_date.beginning_of_year..active_date.end_of_year)
  }

  scope :by_month, -> active_date {
    where(performed_on: active_date.beginning_of_month..active_date.end_of_month)
  }

  scope :by_not_used, -> { where(invoice_id: nil) }
end
