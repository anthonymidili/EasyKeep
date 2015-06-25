class Company < ActiveRecord::Base

  before_validation { |company| company.sales_tax = 0 if company.sales_tax.blank? || company.sales_tax < 0 }

  has_many :users
  has_many :accounts, dependent: :destroy
  has_many :payments
  has_many :invoices
  has_many :inventory_items, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :services

  mount_uploader :logo, LogoUploader

  validates :sales_tax, numericality: true
  validates :name, presence: true
  # validates :established_on,
  #          format: { with: /\A(?<year>\d{4})\-(?<month>\d{1,2})\-(?<day>\d{1,2})\z/,
  #                    message: 'date must be formatted correctly (yyyy-mm-dd)' }

  def full_address
    [address_1, address_2, city, state, zip].select(&:present?).join(', ')
  end

  def owner
    users.find_by_is_owner(true)
  end

  def by_admin
    users.where(is_admin: true)
  end

  def service_provided!
    [service_provided, 'Services'].select(&:present?).join(' ')
  end

  def total_company_invoiced(view_by, active_date)
    invoices.by_selected_range(view_by, active_date).map(&:total_cost).sum
  end

  def total_company_payments(view_by, active_date)
    payments.by_selected_range(view_by, active_date).sum(:amount)
  end

  def total_company_balance_due(view_by, active_date)
    invoices.by_selected_range(view_by, active_date).by_outstanding.sum(&:balance_due)
  end

  def total_less_taxes(view_by, active_date)
    invoices.map { |invoice|
      invoice.payments.by_selected_range(view_by, active_date).sum(:amount) / (invoice.sales_tax! + 1)
    }.sum
  end

  def taxes_applied(view_by, active_date)
    total_company_payments(view_by, active_date) - total_less_taxes(view_by, active_date)
  end

  def money_health(view_by, active_date)
    [total_company_invoiced(view_by, active_date).to_f,
     total_company_payments(view_by, active_date).to_f,
     total_company_balance_due(view_by, active_date).to_f]
  end

  def available_tags
    tags.map(&:name).join(', ')
  end

  def tagged_with(name)
    inventory_items.joins(:tags).where('tags.name' => name)
  end

  def tag_counts
    tags.joins(:taggings).select('tags.*, count(tag_id)').group('tags.id').order('count DESC')
  end
end
