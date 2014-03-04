module InvoicesHelper
  def red_text?(item)
    raw('class="red_text"') if item.not_paid_in_full?
  end

  def pif_or_balance_due(item)
    item.not_paid_in_full? ? number_to_currency(item.balance_due) : 'P. I. F.'
  end
end
