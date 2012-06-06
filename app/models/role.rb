class Role < ActiveRecord::Base
  attr_accessible :name, :rid
  validates_presence_of :name
  has_many :users
end
