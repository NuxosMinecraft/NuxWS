class AddCustomRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :custom_role, :string
  end
end
