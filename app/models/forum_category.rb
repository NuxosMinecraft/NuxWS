class ForumCategory < ActiveRecord::Base
  attr_accessible :name, :position

  # Default order : higher position = bottom

  validates_presence_of :name, :position

  has_many :forums

end
