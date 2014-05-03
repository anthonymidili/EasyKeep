module CompaniesHelper
  def month_in_quarter_date(increment_month_by)
    Date.new(active_date.year, view_quarter + increment_month_by, 1)
  end

  def view_quarter_date
    Date.new(active_date.year, view_quarter, 1)
  end

  def yearly_date(quarter)
    Date.new(active_date.year, quarter, 1)
  end

  def quarter_name
    case view_quarter
      when 1; 'First'
      when 4; 'Second'
      when 7; 'Third'
      else; 'Fourth'
    end
  end

  def quarter_or_year
    case view_by
      when :month; 'quarter'
      else; 'year'
    end
  end
end
