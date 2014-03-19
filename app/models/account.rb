class Account < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :fax, :name, :phone, :state, :zip, :is_a_company

  belongs_to :company
  
  # Keeping belongs_to, accepts_nested_attrubtes_for and attr_accessible all
  # in one place because they are all related to the User.
  belongs_to :user, dependent: :destroy
  accepts_nested_attributes_for :user
  attr_accessible :user_attributes

  has_many :services, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :payments

  validates :name, presence: true

  default_scope order: 'name ASC'

  def full_address
    [ address_1, address_2, city, state, zip ].select(&:present?).join(', ')
  end

  def sum_services(view, date)
    services_items(view, date).sum(&:cost)
  end

  def sum_invoiceable_services
    services.where(invoice_id: nil).sum(&:cost)
  end

  def account_month_total(date)
    time_range = (date.beginning_of_month..date.end_of_month)
    payments.where(received_on: time_range).sum(&:amount)
  end

  def account_quarter_total(date)
    time_range = (date.beginning_of_quarter..date.end_of_quarter)
    payments.where(received_on: time_range).sum(&:amount)
  end

  def account_year_total(date)
    time_range = (date.beginning_of_year..date.end_of_year)
    payments.where(received_on: time_range).sum(&:amount)
  end

  def all_services_invoiced?
    !services.where(invoice_id: nil).present?
  end

  def paid_in_full?
    outstanding_balance = invoices.map(&:not_paid_in_full?)
    !outstanding_balance.include?(true)
  end

private

  def services_items(view_by, active_date)
    services.send(:"by_#{view_by}", active_date)
  end
end
