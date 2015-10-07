module PaymentsHelper
  def amount_or_balance_due(payment)
    payment.amount ||= payment.balance_due_less_payment
  end
end
