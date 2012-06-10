class ForumCategory < ActiveRecord::Base
  attr_accessible :name, :position
  
  default_scope :order => 'position ASC'
  
  validates_presence_of :name, :position
  
  has_many :forums
  
end
