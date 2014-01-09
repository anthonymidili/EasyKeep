module ServicesHelper
  def year_or_month_select
    case view_by
      when :month
        select_date(active_date, discard_day: true)
      else
        select_date(active_date, discard_month: true, discard_day: true)
    end
  end

  def services_with_scope
    # @services.by_range(active_date)
    # or @services.by_month(active_date)
    @services.send(:"by_#{view_by}", active_date)
  end

  def sum_services
    number_to_currency(@services_all.send(:"by_#{view_by}", active_date).sum(&:price))
  end
end
