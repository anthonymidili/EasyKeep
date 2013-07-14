class Account < ActiveRecord::Base

  before_save { |account| account.email = nil if account.email.blank? }

# Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :lockable
  attr_accessible :address_1, :address_2, :city, :email, :password, :password_confirmation, :fax, :name, :phone, :state, :zip


  belongs_to :company

  validates_presence_of   :email, :if => :email_required?
  validates_uniqueness_of :email, :allow_blank => true, :if => :email_changed?
  validates_format_of     :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?

  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of       :password, :within => Devise.password_length, :allow_blank => true

  validates :name, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true

  def full_address
    address_2.blank? ? "#{address_1}" : "#{address_1}, #{address_2}"
  end

  def skip_password!
    @skip_password = true
  end

  def skip_email!
    @skip_email = true
  end

protected

  def password_required?
    !@skip_password && super
  end

  def email_required?
    !@skip_email && super
  end
end