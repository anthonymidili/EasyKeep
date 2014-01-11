class Invoice < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :account
  has_many :services, dependent: :destroy
end
