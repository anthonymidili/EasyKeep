class Company < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :company_name, :fax, :phone, :state, :zip

  belongs_to :admin

  validates :company_name, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true

end
