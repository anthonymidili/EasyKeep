module CompaniesHelper
  def viewing_quarter
    case view_quarter
      when 10
        '4th'
      when 7
        '3rd'
      when 4
        '2nd'
      else
        '1st'
    end

  end
end