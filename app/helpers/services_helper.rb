module ServicesHelper
  def year_or_month_select
    case view_by
      when :year
        select_date(active_date, discard_month: true, discard_day: true)
      else
        select_date(active_date, discard_day: true)
    end
  end

  def services_with_scope
    case view_by
      when :year
        @services.by_year(active_date)
      else
        @services.by_month(active_date)
    end
  end

  def sum_services
    case view_by
      when :year
        number_to_currency(@services_all.by_year(active_date).sum(&:money_received))
      else
        number_to_currency(@services_all.by_month(active_date).sum(&:money_received))
    end
  end
end
