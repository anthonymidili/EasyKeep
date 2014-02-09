module InvoicesHelper
  def red_text?(item)
    raw('class="red_text"') if item.not_paid_in_full?
  end
end
