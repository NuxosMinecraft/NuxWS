class Doc < ActiveRecord::Base
  attr_accessible :title, :content, :modos_only, :description

  default_scope :order => 'created_at DESC'
  
  extend FriendlyId
  friendly_id :title, use: :slugged
    
  paginates_per Settings.pagination_docs
  
  validates_presence_of :title, :description, :content
end
