module ServicesHelper
  def year_or_month_select
    case view_by
      when :month
        select_date(active_date, discard_day: true)
      else
        select_date(active_date, discard_month: true, discard_day: true)
    end
  end

  def services_with_view_by_scope(items)
    # @services.by_year(active_date)
    # or @services.by_month(active_date)
    items.send(:"by_#{view_by}", active_date)
  end
end
