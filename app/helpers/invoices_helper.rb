module InvoicesHelper
  def sub_total(items)
    number_to_currency(items.sum(&:price))
  end

  def tax(items)
    number_to_currency((items.sum(&:price)) * 0.07)
  end
end
