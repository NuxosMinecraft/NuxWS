class Place < ActiveRecord::Base
  attr_accessible :user_id, :name, :short_description, :description, :history, :creators, :various

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :user_id, :name, :short_description

  paginates_per 10

  belongs_to :user
  
  def map_link
    # ?worldname=world&mapname=surface&zoom=4&x=573.7119719902382&y=64&z=467.64595481225604#
    # worldname = self.worldname
    mapname = "surface"
    zoom = "4"
    # x = self.pos_x
    # y = self.pos_y
    # z = self.pos_z
    return "http://map.nuxos-minecraft.fr/"
  end
end
