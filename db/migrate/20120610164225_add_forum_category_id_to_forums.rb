class AddForumCategoryIdToForums < ActiveRecord::Migration
  def change
    rename_column :forums, :section_id, :category_id
  end
end
