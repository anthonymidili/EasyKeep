class Company < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :name, :fax, :phone, :state, :zip, :established_on,
                  :license_number, :service_provided, :service_summery, :website,
                  :logo, :remote_logo_url, :remove_logo, :logo_cache

  has_many :users
  has_many :accounts, dependent: :destroy
  has_many :payments
  has_many :invoices
  has_many :inventory_items, dependent: :destroy
  has_many :tags, dependent: :destroy

  mount_uploader :logo, LogoUploader

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

  def total_company_payments(date, view_by)
    time_range = (date.send("beginning_of_#{view_by}")..date.send("end_of_#{view_by}"))
    payments.where(received_on: time_range).sum(&:amount)
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
    invoices.sum { |invoice|
      invoice.payments.where(received_on: time_range).sum(&:amount) / (invoice.sales_tax! + 1)
    }
  end
end
