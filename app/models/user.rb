class User < ActiveRecord::Base

  validates_presence_of   :username, :password
  validates_uniqueness_of :username, :case_sensative => false

  before_save :hash_password

  def self.authenticate(username, password)
    find_by_username_and_password(username, Digest::MD5.hexdigest(password))
  end


  def hash_password
    self.password = Digest::MD5.hexdigest(self.password) if self.changed.include? 'password'
  end
  private :hash_password

end
