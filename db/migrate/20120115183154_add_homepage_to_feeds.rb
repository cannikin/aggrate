class AddHomepageToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :homepage, :string
  end
end
