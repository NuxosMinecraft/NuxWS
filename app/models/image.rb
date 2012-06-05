class Image < ActiveRecord::Base
  attr_accessible :title, :description, :picture
  mount_uploader :picture, PictureUploader
  
  belongs_to :place
  
  validates_associated :place
end
