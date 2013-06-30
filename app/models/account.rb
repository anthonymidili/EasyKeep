class Account < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :email, :fax, :name, :phone, :state, :zip

  def full_address
    address_2.blank? ? "#{address_1}" : "#{address_1}, #{address_2}"
  end
end
