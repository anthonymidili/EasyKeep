class User < ActiveRecord::Base
  before_save { |account| account.email = nil if account.email.blank? }  # Include default users modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body
  attr_accessor :skip_validation

  has_one :account, dependent: :destroy

  belongs_to :company

  validates_presence_of :email, :unless => :skip_validation?
  validates_uniqueness_of :email, :allow_blank => true, :if => :email_changed?
  validates_format_of :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?

  validates :password, presence: true, confirmation: true, :unless => :skip_validation?
  validates_length_of :password, :within => Devise.password_length, :allow_blank => true

  def skip_validation?
    @skip_validation
  end
end
