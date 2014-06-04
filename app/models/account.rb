class Account < ActiveRecord::Base

  belongs_to :company
  
  # Keeping belongs_to, accepts_nested_attrubtes_for and attr_accessible all
  # in one place because they are all related to the User.
  belongs_to :user, dependent: :destroy
  accepts_nested_attributes_for :user

  has_many :services, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :payments

  validates :name, presence: true

  default_scope { order('name ASC') }

  def full_address
    [ address_1, address_2, city, state, zip ].select(&:present?).join(', ')
  end

  def sum_services(view, date)
    services_items(view, date).sum(:cost)
  end

  def sum_invoiceable_services
    services.where(invoice_id: nil).sum(:cost)
  end

  def total_account_payments(date, view_by)
    time_range = (date.send("beginning_of_#{view_by}")..date.send("end_of_#{view_by}"))
    payments.where(received_on: time_range).sum(:amount)
  end

  def all_services_invoiced?
    !services.where(invoice_id: nil).present?
  end

  def paid_in_full?
    invoices.all?(&:paid_in_full?)
  end

private

  def services_items(view_by, active_date)
    services.send(:"by_#{view_by}", active_date)
  end
end
