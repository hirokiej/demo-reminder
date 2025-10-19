class CreateAddLineAccecctoUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :add_line_acceccto_users do |t|
      t.integer :line_channel_id
      t.string :channel_secret
      t.string :channel_access_token

      t.timestamps
    end
  end
end
