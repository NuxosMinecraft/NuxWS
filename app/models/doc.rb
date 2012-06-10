class Doc < ActiveRecord::Base
  attr_accessible :title, :content, :modos_only, :description
  
  extend FriendlyId
  friendly_id :title, use: :slugged
    
  paginates_per Settings.pagination_docs
end
