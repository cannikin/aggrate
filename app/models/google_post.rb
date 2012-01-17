class GooglePost < ActiveRecord::Base

  scope :accounts, where("user_id != ''")
  scope :searches, where("search_term != ''")

end
