class Log < ActiveRecord::Base
  attr_accessible :category, :priority, :relations, :message
  serialize :relations
  paginates_per 100

  # Default order : latest log at top

  def self.logit!(category, priority, message, relations)
    Log.create(:category => category, :priority => priority, :relations => relations, :message => message)
  end
end
