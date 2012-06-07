class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text   :content 
      t.string :username
      t.integer :edits, :default => 0
      t.integer :last_edit_by
      t.string :slug
      
      t.integer :topic_id
      t.integer :user_id
      t.timestamps
    end
  end
end
