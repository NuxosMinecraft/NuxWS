class ChangeRoles < ActiveRecord::Migration
  def change
    rename_column :users, :role_id, :role
    rename_column :forums, :role_id, :role
    add_column :forum_categories, :role, :integer
  end
end
