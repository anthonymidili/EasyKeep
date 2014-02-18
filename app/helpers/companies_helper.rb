module CompaniesHelper
  def month_in_quarter_date(increment_month_by)
    Date.new(active_date.year, view_quarter + increment_month_by, 1)
  end
end