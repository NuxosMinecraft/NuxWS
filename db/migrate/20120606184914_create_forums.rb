class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :title
      t.text   :description
      t.integer :position
      
      t.integer :section_id
      t.timestamps
    end
  end
end
