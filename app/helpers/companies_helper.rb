module CompaniesHelper
  def month_in_quarter_date(increment_month_by)
    Date.new(active_date.year, view_quarter + increment_month_by, 1)
  end

  def for_quarter
    case view_quarter
      when 1; 'First'
      when 4; 'Second'
      when 7; 'Third'
      else; 'Fourth'
    end
  end
end
