module ReportsHelper
  def month_in_quarter_date(integer)
    Date.new(active_date.year, view_quarter + integer, 1)
  end

  def view_quarter_date
    Date.new(active_date.year, view_quarter, 1)
  end

  def start_of_quarter_date(quarter_for)
    Date.new(active_date.year, quarter_for, 1)
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
