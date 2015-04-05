class Account < ActiveRecord::Base

  belongs_to :company
  
  # Keeping belongs_to, accepts_nested_attrubtes_for and attr_accessible all
  # in one place because they are all related to the User.
  belongs_to :user, dependent: :delete
  accepts_nested_attributes_for :user

  has_many :services, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :payments

  validates :name, presence: true

  scope :by_name, -> { order('name ASC') }
  scope :by_recent_activity, -> { order('updated_at DESC') }
  scope :with_limit, -> { limit(5) }

  def full_address
    [address_1, address_2, city, state, zip].select(&:present?).join(', ')
  end

  def sum_services(view_by, active_date)
    services.by_selected_range(view_by, active_date).sum(:cost)
  end

  def sum_invoiceable_services
    services.by_invoiceable.sum(:cost)
  end

  def total_account_payments(view_by, active_date)
    payments.by_selected_range(view_by, active_date).sum(:amount)
  end

  def all_services_invoiced?
    !services.by_invoiceable.present?
  end

  def paid_in_full?
    invoices.all?(&:paid_in_full?)
  end

  def total_outstanding_invoices
    invoices.by_outstanding.sum(&:balance_due)
  end
end
