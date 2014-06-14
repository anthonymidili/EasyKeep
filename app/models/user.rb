class User < ActiveRecord::Base
  before_save { |account| account.email = nil if account.email.blank? }
  # Include default users modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body
  attr_accessor :skip_validation
  attr_accessor :require_email

  has_one :account, dependent: :destroy

  belongs_to :company

  validates :name, presence: true
  validate :unique_email_required

  default_scope { order('id ASC') }

  scope :by_admin_user, -> { where(is_admin: true) }

  scope :by_owner_user, -> { where(is_owner: true) }

  def password_required?
    super unless @skip_validation
  end
  
  def email_required?
    self.encrypted_password.present? || self.invitation_token.present? || @require_email
  end

private

  def unique_email_required
    if @require_email && company.users.find_by_email(email)
      errors.add(:user, 'email has already been taken') unless email.blank?
    end
  end
end
