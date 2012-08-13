class AddRolesToMailings < ActiveRecord::Migration
  def change
    add_column :mailings, :roles, :string
  end
end
