class Payment < ActiveRecord::Base
  attr_accessible :amount, :received_on, :transaction_type, :memo

  belongs_to :invoice

  validates :amount, presence: true, numericality: true
  validates :received_on,
            format: { with: /^(?<year>\d{4})\-(?<month>\d{1,2})\-(?<day>\d{1,2})$/,
                      message: 'date must be formatted correctly (yyyy-mm-dd)' }

end
