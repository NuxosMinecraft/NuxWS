class Message < ActiveRecord::Base
  attr_accessible :title, :content, :username, :edits, :last_edit_by, :deleted, :deletion_reason
  
  validates_presence_of :title, :content
  
  #extend FriendlyId
  #friendly_id :title, use: :slugged
    
  paginates_per Settings.pagination_messages.to_i
    
  belongs_to :topic
  belongs_to :user
  
  after_save :update_topic_last_message_at
  
  def anonymous?
    !self.username.blank?
  end
  
  def update_topic_last_message_at
    topic = self.topic
    topic.last_message_at = self.created_at
    topic.save
  end
  
end
