class RemovePlaceIdOfImages < ActiveRecord::Migration
  def up
    remove_column :images, :place_id
  end
end
