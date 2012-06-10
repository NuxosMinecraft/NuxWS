class RenameForumCategoryToForumForumCategoryId < ActiveRecord::Migration
  def up
    rename_column :forums, :category_id, :forum_category_id
  end
end
