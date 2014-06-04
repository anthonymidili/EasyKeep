class Payment < ActiveRecord::Base

  before_validation { |payment| payment.amount = 0 if payment.amount.blank? }

  belongs_to :invoice
  belongs_to :company
  belongs_to :account

  validates :amount, numericality: true
  validates :transaction_type, presence: true
  validates :received_on,
            format: { with: /^(?<year>\d{4})\-(?<month>\d{1,2})\-(?<day>\d{1,2})$/,
                      message: 'date must be formatted correctly (yyyy-mm-dd)' }
  validate :no_credit_allowed

  default_scope { order('received_on DESC') }

  # When creating a payment the payment is nil so payment amount is 0.
  # When updating a payment the payment amount is the current payment being edited. Adding the current payment
  # amount to the money_owed amount.
  def balance_due_less_payment
    current_payment = invoice.payments.find_by_id(id)
    payment = current_payment ? current_payment.amount : 0
    invoice.balance_due + payment
  end

private

  def no_credit_allowed
    if amount && amount > balance_due_less_payment
      errors.add(:amount, "can't be greater than total balance due")
    end
  end
end
