class AddMapMarkerToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :map_marker, :string
  end
end
