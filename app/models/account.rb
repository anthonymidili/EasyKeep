class Account < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :email, :fax, :name, :phone, :state, :zip

  validates :name, presence: true
  validates :email, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true

  def full_address
    address_2.blank? ? "#{address_1}" : "#{address_1}, #{address_2}"
  end

end
