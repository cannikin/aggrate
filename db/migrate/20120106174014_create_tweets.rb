class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :username
      t.string :search_term
      t.datetime :last_checked_at

      t.timestamps
    end
  end
end
