class AddRoleIDtoRoles < ActiveRecord::Migration
  def up
    add_column :roles, :rid, :integer
  end
end
