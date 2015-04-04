module InvoicesHelper
  def pif_or_balance_due(invoice)
    case invoice.paid_in_full?
    when true
      'P. I. F.'
    else
      link_to_if current_user.is_admin?, number_to_currency(invoice.balance_due), new_invoice_payment_path(invoice),
                 title: 'Apply Payment', remote: true
    end
  end

  def pif_or_invoice(invoice)
    case invoice.paid_in_full?
      when true
        'P. I. F.'
      else
        link_to number_to_currency(invoice.balance_due), invoice_path(invoice, account_id: invoice.account_id)
    end
  end
end
