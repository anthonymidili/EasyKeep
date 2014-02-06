class Payment < ActiveRecord::Base
  attr_accessible :amount, :received_on, :transaction_type, :memo

  belongs_to :invoice

  validates :amount, presence: true, numericality: true
  validates :transaction_type, presence: true
  validates :received_on,
            format: { with: /^(?<year>\d{4})\-(?<month>\d{1,2})\-(?<day>\d{1,2})$/,
                      message: 'date must be formatted correctly (yyyy-mm-dd)' }
  validate :no_credit_allowed

  default_scope order: 'received_on DESC'

private

  def no_credit_allowed
    if amount && amount > invoice.money_owed
      errors.add(:amount, "can't be greater than total money owed")
    end
  end
end
