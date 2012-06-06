class Topic < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :forum
  belongs_to :user
end
