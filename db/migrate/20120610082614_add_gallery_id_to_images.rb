class AddGalleryIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :gallery_id, :integer
  end
end
