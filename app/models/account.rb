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

  validates :name, presence: true

  default_scope order: 'name ASC'

  def full_address
    [ address_1, address_2, city, state, zip ].select(&:present?).join(', ')
  end

  def sum_services(view, date)
    services_items(view, date).sum(&:cost)
  end

  def sum_invoiceable_services(view, date)
    services_items(view, date).where(invoice_id: nil).sum(&:cost)
  end

  def accounts_totals(active_date)
    quarter = Date.new(active_date.year, 1, 1)
    time_range = (quarter.beginning_of_quarter..quarter.end_of_quarter)
    self.invoices.includes(:payments).where('payments.received_on' => time_range).sum('payments.amount')
  end

private

  def services_items(view_by, active_date)
    services.send(:"by_#{view_by}", active_date)
  end
end
