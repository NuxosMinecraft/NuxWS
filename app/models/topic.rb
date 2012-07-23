class Topic < ActiveRecord::Base
  attr_accessible :title, :content

  validates_presence_of :title, :content

  # Default scope : pinnned at top then latest created at top

  acts_as_readable :on => :last_message_at

  extend FriendlyId
  friendly_id :title, use: :slugged

  paginates_per Settings.pagination_topics.to_i

  belongs_to :forum
  belongs_to :user
  has_many :messages, :dependent => :delete_all

  def anonymous?
    !self.username.blank?
  end

  def pin!
    self.pin = true
    self.save
  end
  def unpin!
    self.pin = false
    self.save
  end

  def lock!
    self.locked = true
    self.save
  end
  def unlock!
    self.locked = false
    self.save
  end

end
