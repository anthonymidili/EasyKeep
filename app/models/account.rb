class Account < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :email, :fax, :name, :phone, :state, :zip
end
