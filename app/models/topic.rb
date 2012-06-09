class Topic < ActiveRecord::Base
  attr_accessible :title, :content, :pin
  
  validates_presence_of :title, :content
  
  extend FriendlyId
  friendly_id :title, use: :slugged
    
  paginates_per Settings.pagination_topics.to_i
    
  belongs_to :forum
  belongs_to :user
  has_many :messages
  
  def anonymous?
    !self.username.blank?
  end
  
end
