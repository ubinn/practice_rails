class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|

      t.text "contents"
      t.string "ip_address"
      t.string "nickname"
      t.string "time"
      t.timestamps
      t.time
      t.date
    end
  end
end
