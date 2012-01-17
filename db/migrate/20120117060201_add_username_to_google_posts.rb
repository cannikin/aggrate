class AddUsernameToGooglePosts < ActiveRecord::Migration
  def change
    add_column :google_posts, :username, :string
  end
end
