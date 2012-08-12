class CreatePms < ActiveRecord::Migration
  def change
    create_table :pms do |t|
      t.integer :user_id
      t.integer :to
      t.string  :subject
      t.text :message

      t.timestamps
    end
  end
end
