class Tweet < ActiveRecord::Base

  scope :accounts, where("username != ''")
  scope :searches, where("search_term != ''")
  
end
