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

  def total_company_payments(date, view_by)
    time_range = (date.send("beginning_of_#{view_by}")..date.send("end_of_#{view_by}"))
    payments.where(received_on: time_range).sum(:amount)
  end

  def total_less_taxes(date, view_by)
    time_range = (date.send("beginning_of_#{view_by}")..date.send("end_of_#{view_by}"))
    less_invoice_tax(time_range)
  end

  def taxes_applied(date, view_by)
    total_company_payments(date, view_by) - total_less_taxes(date, view_by)
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

private

  def less_invoice_tax(time_range)
    invoices.map { |invoice|
      invoice.payments.where(received_on: time_range).sum(:amount) / (invoice.sales_tax! + 1)
    }.sum
  end
end
