class Topic < ActiveRecord::Base
  attr_accessible :title, :content, :pin
  
  validates_presence_of :title, :content
  
  extend FriendlyId
  friendly_id :title, use: :slugged
    
  belongs_to :forum
  belongs_to :user
end
