class AddLineFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :line_channel_id, :string
    add_column :users, :line_channel_secret, :string
    add_column :users, :line_channel_access_token, :string
  end
end
