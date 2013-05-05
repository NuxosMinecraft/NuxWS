class CreateMailings < ActiveRecord::Migration
  def change
    create_table :mailings do |t|
      t.integer :user_id
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
