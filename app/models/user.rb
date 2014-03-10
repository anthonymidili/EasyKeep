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

  validates :name, presence: true
  validate :email_unique

  default_scope order: 'id ASC'

  def password_required?
    super unless @skip_validation
  end
  
  def email_required?
    self.encrypted_password.present? || self.invitation_token.present? || self.is_admin?
  end

private

  def email_unique
    if company.users.find_by_email(email) && is_admin?
      errors.add(:user, 'email has already been taken') unless email.blank?
    end
  end
end
