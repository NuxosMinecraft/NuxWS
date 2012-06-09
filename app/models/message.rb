class Message < ActiveRecord::Base
  attr_accessible :title, :content, :username, :edits, :last_edit_by
  
  validates_presence_of :title, :content
  
  #extend FriendlyId
  #friendly_id :title, use: :slugged
    
  paginates_per Settings.pagination_messages.to_i
    
  belongs_to :topic
  belongs_to :user
  
  def anonymous?
    !self.username.blank?
  end
  
end
