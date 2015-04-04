module AccountsHelper
  def invoiceable_or_not(account)
    case account.all_services_invoiced?
    when true
      'Yes'
    else
      link_to 'No', account_path(account, anchor: 'invoiceable')
    end
  end

  def pif_or_outstanding(account)
    case account.paid_in_full?
    when true
      'Yes'
    else
      link_to 'No', account_path(account, anchor: 'outstanding')
    end
  end
end
