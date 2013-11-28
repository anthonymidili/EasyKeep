class User < ActiveRecord::Base
  before_save { |account| account.email = nil if account.email.blank? }
  # Include default users modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body
  attr_accessor :skip_validation

  has_one :account, dependent: :destroy

  belongs_to :company

  def password_required?
    super unless @skip_validation
  end
  
  def email_required?
    self.encrypted_password.present? || self.invitation_token.present?
  end
end
