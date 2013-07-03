class Company < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :company_name, :fax, :phone, :state, :zip

  belongs_to :admin
end
