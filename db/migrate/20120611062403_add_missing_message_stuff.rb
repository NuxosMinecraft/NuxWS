class AddMissingMessageStuff < ActiveRecord::Migration
  def up
    add_column :messages, :deleted, :boolean, :default => 0
  end
end
