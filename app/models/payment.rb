class Payment < ActiveRecord::Base
  attr_accessible :amount, :invoice_id, :received_on, :type

  belongs_to :invoice
end
