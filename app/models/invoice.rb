class Invoice < ActiveRecord::Base

  extend FriendlyId
  friendly_id :number

  before_validation { |invoice| invoice.sales_tax = 0 if invoice.sales_tax.blank? || invoice.sales_tax < 0 }
  before_create :set_invoice_number

  belongs_to :account, touch: true
  accepts_nested_attributes_for :account

  belongs_to :company

  has_many :services
  accepts_nested_attributes_for :services # , reject_if: proc { |service| service['cost'] = 0 }

  has_many :payments, dependent: :destroy

  validates :sales_tax, numericality: true
  validates :established_at,
            format: { with: /\A(?<year>\d{4})\-(?<month>\d{1,2})\-(?<day>\d{1,2})\z/,
                      message: 'date must be formatted correctly (yyyy-mm-dd)' }
  validate :invoice_number_presence, on: :update
  validate :company_invoice_number_unique, on: :update

  include SelectedRange
  # def by_selected_range(view_by, active_date)
  #   time_range = (active_date.send("beginning_of_#{view_by}")..active_date.send("end_of_#{view_by}"))
  #   where(:established_at => time_range)
  # end

  default_scope { order('established_at DESC') }

  scope :by_outstanding, -> { all.reject(&:paid_in_full?) }
  scope :by_most_recent, -> { order('established_at DESC') }

  def pre_post_number
    [account.prefix, self.number, account.postfix].select(&:present?).join(account.divider)
  end

  def sales_tax!
    sales_tax * 0.01
  end

  def sub_total
    services.sum(:cost)
  end

  def services_sales_tax
    sub_total * sales_tax!
  end

  def total_cost
    (sub_total + services_sales_tax).round(2)
  end

  def payments_total
    payments.sum(:amount)
  end

  def balance_due
    total_cost - payments_total
  end

  def paid_in_full?
    balance_due == 0.00
  end

  def archived?
    payments.any?
  end

  def disable_link_if_archived?
    'disable_link gray_text' if archived?
  end

private

  # Sets the invoice number just before the invoice is created.
  def set_invoice_number
    self.number = (company.invoices.maximum(:number).to_i).succ
  end

  # Validates that the invoice [number] is present.
  # If not the invoice [number] is rescued to avoid routing errors.
  def invoice_number_presence
    unless number
      rescue_invoice_number
      errors.add(:invoice_number, "can't be blank")
    end
  end

  # Validates that the invoice [number] being updated is not used by another
  # Company Invoice if the invoice [number] has been changed.
  # If so it's rescued to avoid routing errors.
  def company_invoice_number_unique
    if number && invoice_number_exists?
      rescue_invoice_number
      errors.add(:invoice_number, 'already exists')
    end
  end

  # Finds if the invoice [number] already exists.
  def invoice_number_exists?
    (company.invoices.pluck(:number) - [current_invoice.number]).include?(number)
  end

  # Finds the user's invoice they are currently editing.
  def current_invoice
    @current_invoice ||= company.invoices.find(self.id)
  end

  # Resets the user's invoice [number] they are currently editing, if an error occurs.
  def rescue_invoice_number
    self.number = current_invoice.number
  end
end
