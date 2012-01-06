class Feed < ActiveRecord::Base

  has_many    :entries, :as => :source, :dependent => :destroy

end
