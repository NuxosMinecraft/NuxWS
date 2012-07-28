class AddRoleIdToForums < ActiveRecord::Migration
  def change
    add_column :forums, :role_id, :integer
  end
end
