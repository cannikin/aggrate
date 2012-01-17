class CreateGooglePosts < ActiveRecord::Migration
  def change
    create_table :google_posts do |t|
      t.string :user_id
      t.string :search_term
      t.datetime :last_checked_at
      t.text :last_error

      t.timestamps
    end
  end
end
