class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :title
      t.text :content
      t.text :description
      
      t.boolean :modos_only
      
      t.string :slug
      t.timestamps
    end
  end
end
