class Gallery < ActiveRecord::Base
  attr_accessible :title, :description, :place_id, :images_attributes
  
  extend FriendlyId
  friendly_id :title, use: :slugged
    
  has_many :images
  has_one :place
  
  accepts_nested_attributes_for :images, :allow_destroy => true
  
  paginates_per Settings.pagination_galleries
end
