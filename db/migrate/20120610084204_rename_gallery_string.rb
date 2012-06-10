class RenameGalleryString < ActiveRecord::Migration
  def up
    rename_column :galleries, :string, :title
  end
end
