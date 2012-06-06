class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.boolean :moderation, :null => false, :default => 0
      t.boolean :pin, :null => false, :default => 0
      t.boolean :locked, :null => false, :default => 0
      
      t.integer :forum_id
      t.integer :user_id
      t.timestamps
    end
  end
end
