class AddLastErrorToTweetsAndFeeds < ActiveRecord::Migration
  def change
    add_column :tweets, :last_error, :text
    add_column :feeds,  :last_error, :text
  end
end
