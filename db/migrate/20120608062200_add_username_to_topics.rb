class AddUsernameToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :username, :string
  end
end
