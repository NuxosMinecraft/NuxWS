class Place < ActiveRecord::Base
  attr_accessible :user_id, :name, :short_description, :description, :history, :creators, :various

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :user_id, :name, :short_description

  paginates_per 10

  belongs_to :user
end
