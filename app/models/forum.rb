class Forum < ActiveRecord::Base
  attr_accessible :title, :description, :position, :forum_category_id
  
  default_scope :order => 'position ASC'
  
  validates_presence_of :title, :forum_category_id
  
  paginates_per Settings.pagination_topics.to_i
  
  has_many :topics, :dependent => :delete_all
  has_one :forum_category
end
