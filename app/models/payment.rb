class Payment < ActiveRecord::Base

  before_validation { |payment| payment.amount = 0 if payment.amount.blank? }

  belongs_to :account, touch: true
  belongs_to :company
  belongs_to :invoice

  validates :amount, numericality: true
  validates :transaction_type, presence: true
  validates :received_on,
            format: { with: /\A(?<year>\d{4})\-(?<month>\d{1,2})\-(?<day>\d{1,2})\z/,
                      message: 'date must be formatted correctly (yyyy-mm-dd)' }
  validate :no_credit_allowed

  include SelectedRange
  # def by_selected_range(view_by, active_date)
  #   time_range = (active_date.send("beginning_of_#{view_by}")..active_date.send("end_of_#{view_by}"))
  #   where(:received_on => time_range)
  # end

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
