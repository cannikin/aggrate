require Rails.root.join('lib','runners','helpers')

module Aggrate
  module Runners
    class Tweets

      def self.run

        puts "Starting tweets service at #{Time.now}..."

        helpers = Helpers.new
        
        Tweet.all.each do |tweet|
          puts tweet.username + tweet.search_term
          begin

            if tweet.username.present?
              # all tweets by a given user
              raw_statuses = Twitter.user_timeline(tweet.username)
              statuses = raw_statuses.collect do |s|
                { :id => s.id,
                  :text => s.text,
                  :created_at => s.created_at,
                  :screen_name => s.user.screen_name,
                  :profile_image_url => s.user.profile_image_url }
              end
            elsif tweet.search_term.present?
              # all tweets matching a search term
              raw_statuses = Twitter.search(tweet.search_term, :result_type => 'recent')
              statuses = raw_statuses.collect do |s|
                { :id => s.id,
                  :text => s.text,
                  :created_at => s.created_at,
                  :screen_name => s.from_user,
                  :profile_image_url => s.profile_image_url }
              end
            end

            statuses.each do |status|
              if Entry.find_by_guid status[:id]
                puts "    Exiting, matched GUID"
                break
              else
                puts "  New entry: #{status[:id]}"
                create_entry(status, tweet)
              end
            end

            # remove any previous errors after a successful run
            tweet.update_attribute :last_error, nil

          rescue => e
            puts "    !!!! ERROR: #{e.inspect}"
            tweet.update_attribute :last_error, [e, e.backtrace].flatten.join("\n")
            raise e
          end
          tweet.update_attribute :last_checked_at, Time.now
        end

      end


      def self.create_entry(status, tweet)
        Entry.create( :guid => status[:id], 
                      :title => '@' + status[:screen_name], 
                      :description => status[:text], 
                      :pub_time => status[:created_at].to_s(:db),
                      :link => "https://twitter.com/#!/#{status[:screen_name]}/status/#{status[:id]}",
                      :image => status[:profile_image_url],
                      :source => tweet)
      end


    end
  end
end
