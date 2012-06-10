class AddMissingSlugs < ActiveRecord::Migration
  def up
    add_column :galleries, :slug, :string
    add_column :images, :slug, :string
  end
end
