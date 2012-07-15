class Doc < ActiveRecord::Base
  attr_accessible :title, :content, :modos_only, :description

  default_scope :order => 'created_at DESC'
  before_update :restrict_update_attrs

  extend FriendlyId
  friendly_id :title, use: :slugged

  paginates_per Settings.pagination_docs

  validates_presence_of :title, :description, :content

  def restrict_update_attrs
    restrict = 0
    if User.current
      if !User.current.at_least_modo?
        restrict = 1
      end
    else
      restrict = 1
    end

    if !restrict
      self.modos_only = self.modos_only_was if self.modos_only_changed?
    end
  end

end
