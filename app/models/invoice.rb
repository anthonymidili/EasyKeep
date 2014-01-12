class Invoice < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :account
  has_many :services, dependent: :destroy

  default_scope order: 'created_at DESC'

  def sub_total
    self.services.sum(&:price)
  end

  def tax
    sub_total * 0.07
  end

  def total_cost
    sub_total + tax
  end
end
