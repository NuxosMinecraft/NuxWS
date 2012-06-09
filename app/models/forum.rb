class Forum < ActiveRecord::Base
  attr_accessible :title, :description, :position
  
  validates_presence_of :title
  
  paginates_per Settings.pagination_topics.to_i
  
  has_many :topics
end
