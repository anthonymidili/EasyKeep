module InvoicesHelper
  def pif_or_balance_due(item)
    case item.paid_in_full?
      when true
        'P. I. F.'
      else
        link_to_if current_user.is_admin?, number_to_currency(item.balance_due), new_invoice_payment_path(item),
                   title: 'Apply Payment', remote: true
    end
  end
end
