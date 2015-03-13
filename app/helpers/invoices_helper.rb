module InvoicesHelper
  def red_text?(item)
    'red_text' unless item.paid_in_full?
  end

  def pif_or_balance_due(item)
    if item.paid_in_full?
      'P. I. F.'
    else
      link_to_if current_user.is_admin?, number_to_currency(item.balance_due), new_invoice_payment_path(item),
              title: 'Apply Payment', remote: true
    end
  end
end
