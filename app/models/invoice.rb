class Invoice < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :account

  has_many :services
  has_many :payments, dependent: :destroy

  default_scope order: 'created_at DESC'

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
