class CreateFriends < ActiveRecord::Migration[8.0]
  def change
    create_table :friends do |t|
      t.references :user, null: false, foreign_key: true
      t.string :line_user_id
      t.string :line_display_name
      t.string :real_name

      t.timestamps
    end
  end
end
