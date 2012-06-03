class User < ActiveRecord::Base
  attr_accessible :login, :password, :password_confirmation, :email, :jid

  include SentientUser
  extend FriendlyId
  friendly_id :login, use: :slugged
  acts_as_authentic

  validates_presence_of :login, :password, :password_confirmation, :email

  has_many :places

  paginates_per 20

  after_create :create_default_role

  def create_default_role
    self.role = "user"
    if User.find_all_by_role("admin").count == 0
      self.role = "admin"
    end
    self.save
  end

  def admin?
    return (self.role == "admin") ? true : false
  end

end
