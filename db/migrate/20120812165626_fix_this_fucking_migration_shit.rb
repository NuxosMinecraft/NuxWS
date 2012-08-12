class FixThisFuckingMigrationShit < ActiveRecord::Migration
  def up
    add_column :topic_notifications, :user_id, :integer
    add_column :topic_notifications, :topic_id, :integer
  end
end
