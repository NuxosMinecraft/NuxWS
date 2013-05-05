class AddReadStatusToPms < ActiveRecord::Migration
  def change
    add_column :pms, :read, :boolean, :default => 0
  end
end
