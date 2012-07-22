class Gallery < ActiveRecord::Base
  attr_accessible :title, :description, :place_id, :images_attributes

  default_scope :order => 'created_at DESC'

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :images, :dependent => :delete_all
  has_one :place

  accepts_nested_attributes_for :images, :allow_destroy => true

  paginates_per Settings.pagination_galleries.to_i

  validates_presence_of :title
end
