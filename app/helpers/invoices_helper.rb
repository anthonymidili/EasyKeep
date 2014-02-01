module InvoicesHelper
  def red_text?(item)
    raw('class="red_text"') if item.money_owed > 0
  end
end
