class User < ActiveRecord::Base
  attr_accessible :login, :password, :password_confirmation, :email, :jid

  include SentientUser
  extend FriendlyId
  friendly_id :login, use: :slugged
  acts_as_authentic

  validates_presence_of :login, :password, :password_confirmation, :email

  has_many :places
  belongs_to :role
  
  paginates_per 20

  after_create :create_default_role

  def create_default_role
    self.role = Role.find_by_id(0)
    if User.count == 0
      self.role = Role.find_by_id(16)
    end
    self.save
  end

  def admin?
    return (self.role.id == 16) ? true : false
  end

end
