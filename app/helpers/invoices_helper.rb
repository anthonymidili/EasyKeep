module InvoicesHelper
  def red_text?(item)
    'red_text' if !item.paid_in_full?
  end

  def pif_or_balance_due(item)
    if item.paid_in_full?
      'P. I. F.'
    else
      link_to number_to_currency(item.balance_due), new_invoice_payment_path(item),
              title: 'Apply Payment',remote: true if current_user.is_admin?
    end
  end
end
