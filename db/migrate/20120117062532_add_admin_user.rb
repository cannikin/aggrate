class AddAdminUser < ActiveRecord::Migration
  def up
    User.create :username => 'admin', :password => 'password'
  end

  def down
    User.find_by_username('admin').destroy
  end
end
