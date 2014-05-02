module InvoicesHelper
  def red_text?(item)
    'red_text' if !item.paid_in_full?
  end

  def pif_or_balance_due(item)
    !item.paid_in_full? ? number_to_currency(item.balance_due) : 'P. I. F.'
  end
end
