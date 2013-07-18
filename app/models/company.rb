class Company < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :name, :fax, :phone, :state, :zip

  has_many :users

  has_many :accounts, dependent: :destroy

  validates :name, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true
end
