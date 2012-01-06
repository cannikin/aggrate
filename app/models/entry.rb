class Entry < ActiveRecord::Base

  belongs_to  :source, :polymorphic => true

  scope :latest, lambda { |num| order('pub_time desc').limit(num) }

end
