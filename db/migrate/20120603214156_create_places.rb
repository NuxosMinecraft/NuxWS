class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false
      t.text :short_description, :null => false
      t.text :description
      t.text :history
      t.text :creators
      t.text :various
      
      t.string :slug
      
      t.timestamps
    end
  end
end
