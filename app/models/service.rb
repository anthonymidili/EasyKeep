class Service < ActiveRecord::Base

  before_validation { |service| service.cost = 0 if service.cost.blank? }

  belongs_to :account, touch: true
  belongs_to :invoice
  belongs_to :company

  validates :cost, numericality: true
  validates :performed_on,
            format: { with: /\A(?<year>\d{4})\-(?<month>\d{1,2})\-(?<day>\d{1,2})\z/,
                      message: 'date must be formatted correctly (yyyy-mm-dd)' }

  default_scope { order('performed_on DESC') }

  scope :by_selected_range, -> view_by, active_date {
    time_range = (active_date.send("beginning_of_#{view_by}")..active_date.send("end_of_#{view_by}"))
    where(performed_on: time_range)
  }

  scope :by_not_used, -> { where(invoice_id: nil) }

  scope :with_limit, -> { limit(5) }

  def disable_if_payment
    'disable_link gray_text' if invoice_id.present? && invoice.payments.any?
  end
end
