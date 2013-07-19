class User < ActiveRecord::Base
  before_save { |account| account.email = nil if account.email.blank? }  # Include default users modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body

  has_one :account, dependent: :destroy

  belongs_to :company

  # validates_presence_of   :email, :if => :email_required?
  validates_uniqueness_of :email, :allow_blank => true, :if => :email_changed?
  validates_format_of     :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?

  # validates_presence_of     :password, :if => :password_required?
  # validates_confirmation_of :password, :if => :password_required?
  validates_length_of       :password, :within => Devise.password_length, :allow_blank => true

  # def skip_password!
  #   @skip_password = true
  # end

  # def skip_email!
  #   @skip_email = true
  # end

  # protected

  # def password_required?
  #   !@skip_password && super
  # end

  # def email_required?
  #   !@skip_email && super
  # end
end
