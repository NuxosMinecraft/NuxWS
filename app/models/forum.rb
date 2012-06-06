class Forum < ActiveRecord::Base
  attr_accessible :title, :description, :position
  
  validates_presence_of :title
end
