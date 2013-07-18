class Account < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :fax, :name, :phone, :state, :zip

  belongs_to :company
  
  # Keeping belongs_to, accepts_nested_attrubtes_for and attr_accessible all
  # in one place because they are all related to the User.
  belongs_to :user
  accepts_nested_attributes_for :user
  attr_accessible :user_attributes

  validates :name, presence: true
  

  def full_address
    [ address_1, address_2 ].select(&:present?).join(', ')
  end
end
