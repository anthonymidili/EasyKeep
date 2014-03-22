class Company < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :name, :fax, :phone, :state, :zip,
                  :established_on, :license_number, :service_provided, :service_summery

  has_many :users
  has_many :accounts, dependent: :destroy
  has_many :payments
  has_many :invoices

  validates :name, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true

  def full_address
    [ address_1, address_2, city, state, zip ].select(&:present?).join(', ')
  end

  def owner
    users.find_by_is_owner(true)
  end

  def by_admin
    users.where(is_admin: true)
  end

  def service_provided!
    service_provided.present? ? "#{service_provided} Services" : 'Services'
  end

  def company_month_total(date)
    time_range = (date.beginning_of_month..date.end_of_month)
    payments.where(received_on: time_range).sum(&:amount)
  end

  def company_quarter_total(date)
    time_range = (date.beginning_of_quarter..date.end_of_quarter)
    payments.where(received_on: time_range).sum(&:amount)
  end

  def company_year_total(date)
    time_range = (date.beginning_of_year..date.end_of_year)
    payments.where(received_on: time_range).sum(&:amount)
  end

  def quarterly_total_less_taxes(date)
    company_quarter_total(date) / 1.07
  end

  def yearly_total_less_taxes(date)
    company_year_total(date) / 1.07
  end

  def quarterly_taxes_applied(date)
    company_quarter_total(date) - quarterly_total_less_taxes(date)
  end

  def yearly_taxes_applied(date)
    company_year_total(date) - yearly_total_less_taxes(date)
  end
end
