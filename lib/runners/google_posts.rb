require Rails.root.join('lib','runners','helpers')

module Aggrate
  module Runners
    class GooglePosts
      
      def self.run

        puts "Starting google post service at #{Time.now}..."

        helpers = Helpers.new

        GooglePost.all.each do |search|
          puts search.user_id + search.search_term
          begin
            if search.user_id.present?
              result = Plus::Activities.list search.user_id
            elsif search.search_term.present?
              result = Plus::Activities.search search.search_term
            end

            result['items'].each do |item|
              if Entry.find_by_guid item['id']
                puts "    Exiting, matched GUID"
                break
              else
                puts "  New entry: #{item['id']}"
                Entry.create( :guid => item['id'], 
                              :title => '+' + item['actor']['displayName'], 
                              :description => helpers.truncate(helpers.strip_tags(item['object']['content']), :length => 300, :separator => ' '), 
                              :pub_time => Time.parse(item['published']).to_s(:db),
                              :link => item['url'],
                              :image => item['actor']['image']['url'],
                              :source => search)
              end
            end

            # remove any previous errors after a successful run
            search.update_attribute :last_error, nil
          rescue => e
            puts "   !!!! ERROR: #{e.inspect}"
            search.update_attribute :last_error, [e, e.backtrace].flatten.join("\n")
            raise e
          end
          
          search.update_attribute :last_checked_at, Time.now
        end

      end

    end
  end
end
