module AccountsHelper
  def yes_or_no(boolean)
    case boolean
      when true; 'Yes'
      else; 'No'
    end
  end
end