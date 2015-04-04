module InvoicesHelper
  def pif_or_balance_due(invoice)
    link = link_to_if current_user.is_admin?, number_to_currency(invoice.balance_due), new_invoice_payment_path(invoice),
               title: 'Apply Payment', remote: true

    true_or_false(invoice, link)
  end

  def pif_or_invoice(invoice)
    link = link_to number_to_currency(invoice.balance_due), invoice_path(invoice, account_id: invoice.account_id)

    true_or_false(invoice, link)
  end

private

  def true_or_false(invoice, link)
    case invoice.paid_in_full?
    when true
      'P. I. F.'
    else
      link
    end
  end
end
