module InvoicesHelper
  def red_text?(item)
    raw('class="red_text"') if item.money_is_owed?
  end
end
