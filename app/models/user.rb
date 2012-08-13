class User < ActiveRecord::Base
  attr_accessible :password, :password_confirmation, :email, :jid, :login, :role, :signature, :custom_role

  # Default order : latest created at top

  include SentientUser
  extend FriendlyId
  friendly_id :login, use: :slugged
  acts_as_authentic
  acts_as_reader

  validates_presence_of :password, :password_confirmation, :on => :create
  validates_presence_of :login, :email
  validates :login, :validate_minecraft_login_and_not_hacked => true
  has_many :places
  has_many :topics
  has_many :messages
  has_many :pms
  has_many :topic_notifications, :dependent => :delete_all
  has_many :mailings

  paginates_per Settings.pagination_users.to_i

  before_create :create_default_role
  before_update :restrict_update_attrs

  def create_default_role
    self.role = Role.get_id(:guest)
    if User.count == 0
      self.role = Role.get_id(:admin)
    end
  end

  def role_name
    self.role_sym.to_s
  end
  def role_sym
    Role.get_sym(self.role)
  end

  def admin?
    self.role == Role.get_id(:admin)
  end

  def at_least_modo?
    self.role >= Role.get_id(:moderator)
  end

  def restrict_update_attrs
    restrict = nil
    if User.current
      if !User.current.at_least_modo?
        restrict = 1
      end
    else
      # that should never happend
      # CanCan will manage that for us
    end

    if restrict
      self.login = self.login_was if self.login_changed?
      self.role = self.role_was if self.role_changed?
    end
  end

  def unread_pms
    Pm.where(:read => 0, :to => self.id)
  end

  def sent_pms
    self.pms
  end

  def received_pms
    Pm.where(:to => self.id)
  end

def sendmail_deliver_password_reset_instructions!
  reset_perishable_token!
  Notifier.password_reset_instructions(self).deliver
end
def sendmail_register_notify_user!
  Notifier.register_notify_user(self).deliver
end
def sendmail_register_notify_admins!
  Notifier.register_notify_admins(self).deliver
end

end
