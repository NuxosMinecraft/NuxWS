class AddLastMessageAtForTopics < ActiveRecord::Migration
  def up
    add_column :topics, :last_message_at, :timestamp
    add_index :topics, :last_message_at
  end
end
