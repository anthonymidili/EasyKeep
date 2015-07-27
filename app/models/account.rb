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
  validate :company_account_name_unique

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

private

  # Check for Company Account name uniqueness.
  def company_account_name_unique
    errors.add(:name, 'already exists') if name && account_name_exists?
  end

  # If account is being updated, find the current account the user is updating and remove that account's name
  # from the array. Then check if the form [name] being submitted is present. This allows account to be updated
  # while validating the form [name] submitted is unique.
  # If account is being created, there is no [id], and no names will be removed from the array.
  def account_name_exists?
    (company.accounts.pluck(:name) - [current_account.try(:name)]).include?(name)
  end

  # Use find_by :id method so if there is no [id] present, current_account returns nil.
  def current_account
    @current_account ||= company.accounts.find_by(id: self.id)
  end
end
