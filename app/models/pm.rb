class Pm < ActiveRecord::Base
  attr_accessible :message, :to, :subject, :user_id

  validates_presence_of :message, :to
  validates :to, :validate_pm_to_user => true

  acts_as_readable

  belongs_to :user

  def pm_notify_user!
    Notifier.pm_notify_user(self).deliver
  end
end
