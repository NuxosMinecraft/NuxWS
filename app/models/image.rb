class Image < ActiveRecord::Base
  attr_accessible :title, :description, :picture, :picture_cache, :remote_picture_url
  mount_uploader :picture, PictureUploader

  # Default order : latest image at end

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :gallery

  validates_associated :gallery
  validates_presence_of :title, :picture

  paginates_per Settings.pagination_images.to_i
end
