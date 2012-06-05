class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer "place_id"
      t.string  "title"
      t.text    "description"
      t.timestamps
    end
  end
end
