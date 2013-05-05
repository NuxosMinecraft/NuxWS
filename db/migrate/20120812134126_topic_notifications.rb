class TopicNotifications < ActiveRecord::Migration
  def change
    create_table :topic_notifications do |t|
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end
  end
end
