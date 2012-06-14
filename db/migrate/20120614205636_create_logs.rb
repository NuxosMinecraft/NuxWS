class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :category
      t.string :priority
      
      t.text :relations
      t.timestamps
    end
  end
end
