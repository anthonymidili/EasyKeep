module ServicesHelper
  def year_or_month_select
    case view_by
    when :month
      select_date(active_date, discard_day: true)
    else
      select_date(active_date, discard_month: true, discard_day: true)
    end
  end
end
