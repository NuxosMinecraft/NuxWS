class Place < ActiveRecord::Base
  attr_accessible :user_id, :name, :short_description, :description, :history, :creators, :various, :map_marker

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :user_id, :name, :short_description

  paginates_per 10

  belongs_to :user
  
  def map_link
    # ?worldname=world&mapname=surface&zoom=4&x=573.7119719902382&y=64&z=467.64595481225604#
    worldname = "world" # FIXED for the moment...
    mapname = "surface"
    zoom = "4"
    # map_marker = "x/y/z"
    return nil if !self.map_marker
    pos = self.map_marker.split("/")
    x = pos[0]
    y = pos[1]
    z = pos[2]
    return "http://map.nuxos-minecraft.fr/?worldname=#{worldname}&mapname=#{mapname}&zoom=#{zoom}&x=#{x}&y=#{y}&z=#{z}"
  end
end
