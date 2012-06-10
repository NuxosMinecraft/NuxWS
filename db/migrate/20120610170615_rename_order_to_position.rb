class RenameOrderToPosition < ActiveRecord::Migration
  def up
    rename_column :forum_categories, :order, :position
  end
end
