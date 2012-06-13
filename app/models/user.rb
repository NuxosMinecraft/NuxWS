class User < ActiveRecord::Base
  attr_accessible :login, :password, :password_confirmation, :email, :jid

  default_scope :order => 'created_at DESC'

  include SentientUser
  extend FriendlyId
  friendly_id :login, use: :slugged
  acts_as_authentic
  acts_as_reader
  
  validates_presence_of :login, :password, :password_confirmation, :email
  validates :login, :validate_minecraft_login_and_not_hacked => true
  has_many :places
  belongs_to :role
  has_many :topics
  has_many :messages
  
  paginates_per Settings.pagination_users.to_i

  after_create :create_default_role

  def create_default_role
    self.role = Role.find_by_rid("1")
    if User.count == 0
      self.role = Role.find_by_rid("16")
    end
    self.save
  end

  def admin?
    return false if !self.role
    return (self.role.rid == 16)
  end

  def at_least_modo?
    return false if !self.role
    return (self.role.rid >= 12)
  end

end
