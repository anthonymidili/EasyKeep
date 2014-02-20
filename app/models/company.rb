class Company < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :name, :fax, :phone, :state, :zip

  has_many :users
  has_many :accounts, dependent: :destroy
  has_many :payments

  validates :name, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true

  def full_address
    [ address_1, address_2, city, state, zip ].select(&:present?).join(', ')
  end

  def owner_name
    users.where(is_owner: true).map(&:name).join(', ')
  end

  def owner_email
    users.where(is_owner: true).map(&:email).join(', ')
  end

  def by_admin
    users.where(is_admin: true)
  end

  def company_month_total(month_in_quarter_of)
    time_range = (month_in_quarter_of.beginning_of_month..month_in_quarter_of.end_of_month)
    payments.where(received_on: time_range).sum(&:amount)
  end

  def sum_quarter(active_date, view_quarter)
    quarter = Date.new(active_date.year, view_quarter, 1)
    time_range = (quarter.beginning_of_quarter..quarter.end_of_quarter)
    payments.where(received_on: time_range).sum(&:amount)
  end

  def taxes_applied(active_date, view_quarter)
    sum_quarter(active_date, view_quarter) * 0.07
  end
end
