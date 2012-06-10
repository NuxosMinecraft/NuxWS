class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :string, :null => false
      t.text :description
      
      t.integer :place_id
      
      t.timestamps
    end
  end
end
