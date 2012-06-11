class AddMissingMessageDeletionInfos < ActiveRecord::Migration
  def up
    add_column :messages, :deletion_reason, :string
    add_column :messages, :deletion_by, :integer
  end
end
