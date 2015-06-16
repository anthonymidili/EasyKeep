module UsersHelper
  def yes_or_no(boolean)
    case boolean
    when true
      'Yes'
    else
      'No'
    end
  end

  def edit_email_address(account_user)
    if account_user.encrypted_password.present? && current_user.is_admin?
      'Only the customer can change their email address once they are an Active user.'
    elsif account_user.encrypted_password.present? && account_user == current_user
      'Email can be edited in User/User Settings'
    else
      "Once a customer becomes an Active user, admins will not be able to edit the customer's Email. This is to prevent the customer from not being able to log on to their account."
    end
  end
end
