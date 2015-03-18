class Invoice < ActiveRecord::Base

  before_validation { |invoice| invoice.sales_tax = 0 if invoice.sales_tax.blank? || invoice.sales_tax < 0 }

  belongs_to :account, touch: true
  belongs_to :company

  has_many :services
  has_many :payments, dependent: :destroy

  validates :sales_tax, numericality: true
  validates :established_at,
            format: { with: /\A(?<year>\d{4})\-(?<month>\d{1,2})\-(?<day>\d{1,2})\z/,
                      message: 'date must be formatted correctly (yyyy-mm-dd)' }

  default_scope { order('established_at DESC') }

  scope :by_outstanding, -> { all.reject(&:paid_in_full?) }

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

  def disable_if_payment
    'disable_link gray_text' if payments.any?
  end
end
