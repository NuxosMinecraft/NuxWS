class Image < ActiveRecord::Base
  attr_accessible :title, :description, :picture, :picture_cache
  mount_uploader :picture, PictureUploader
  
  extend FriendlyId
  friendly_id :title, use: :slugged
    
  belongs_to :gallery
  
  validates_associated :gallery
  validates_presence_of :title, :picture
  
  paginates_per Settings.pagination_images
end
