class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable
  attr_accessible :address_1, :address_2, :city, :email, :password, :password_confirmation, :fax, :name, :phone, :state, :zip

  belongs_to :company

  validates :name, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true

  def full_address
    address_2.blank? ? "#{address_1}" : "#{address_1}, #{address_2}"
  end

end
