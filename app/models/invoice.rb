class Invoice < ActiveRecord::Base
  attr_accessible :established_at

  belongs_to :account
  belongs_to :company

  has_many :services
  has_many :payments, dependent: :destroy

  validates :established_at,
            format: { with: /^(?<year>\d{4})\-(?<month>\d{1,2})\-(?<day>\d{1,2})$/,
                      message: 'date must be formatted correctly (yyyy-mm-dd)' }

  default_scope order: 'established_at DESC'

  def sub_total
    self.services.sum(&:cost)
  end

  def tax
    sub_total * 0.07
  end

  def total_cost
    sub_total + tax
  end

  def payments_total
    self.payments.sum(&:amount)
  end

  def balance_due
    total_cost - payments_total
  end

  def not_paid_in_full?
    balance_due >= 0.01
  end
end
