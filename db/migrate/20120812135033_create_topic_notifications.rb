class CreateTopicNotifications < ActiveRecord::Migration
  def change
    create_table :topic_notifications do |t|

      t.timestamps
    end
  end
end
