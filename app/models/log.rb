class Log < ActiveRecord::Base
  attr_accessible :category, :priority, :relations, :message
  serialize :relations
  paginates_per 100
  default_scope :order => 'created_at DESC'
  
  def self.logit!(category, priority, message, relations)
    Log.create(:category => category, :priority => priority, :relations => relations, :message => message)
  end
end
