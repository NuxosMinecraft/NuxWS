class Message < ActiveRecord::Base
  attr_accessible :title, :content, :username, :edits, :last_edit_by, :deleted, :deletion_reason

  validates_presence_of :title, :content

  #extend FriendlyId
  #friendly_id :title, use: :slugged

  paginates_per Settings.pagination_messages.to_i

  belongs_to :topic
  belongs_to :user

  after_save :update_topic_last_message_at
  before_update :restrict_update_attrs

  def anonymous?
    !self.username.blank?
  end

  def update_topic_last_message_at
    topic = self.topic
    topic.last_message_at = self.created_at
    topic.save
  end

  def restrict_update_attrs
    restrict = 0
    if User.current
      if !User.current.at_least_modo?
        restrict = 1
      end
    else
      restrict = 1
    end

    if !restrict
      self.deleted = self.deleted_was if self.deleted_changed?
      self.deletion_reason = self.deletion_reason_was if self.deletion_reason_changed?
    end
  end

  def notify_users_topic_update!(cur_user)
    TopicNotification.where(:topic_id => self.topic.id).each do |rel|
      next if (rel.user_id == cur_user.id)
      Notifier.notify_users_topic_update(self, rel.user).deliver
    end
  end

end
