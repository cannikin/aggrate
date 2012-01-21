require 'syndication/rss'
require 'syndication/atom'
require 'open-uri'
require Rails.root.join('lib','runners','helpers')

module Aggrate
  module Runners
    class Feeds

      def self.run
        puts "Starting feeds at #{Time.now}..."

        helpers = Helpers.new

        Feed.order('id desc').all.each do |feed|
          puts feed.title
          begin
            content = open(feed.link).read
            if content.match(/<rss/)
              puts " - RSS"
              parsed_feed = Syndication::RSS::Parser.new.parse(content)
              parsed_feed.items.each do |item|
                if Entry.find_by_guid item.guid
                  puts "    Exiting, matched GUID"
                  break
                else
                  image = parsed_feed.channel.image ? parsed_feed.channel.image.url : nil
                  if image.nil? and description_image = item.description.match(/<img.*?src=['"](.*?)['"]/)
                    image = description_image[1]
                  end
                  puts "  New entry: #{item.guid}"
                  Entry.create( :guid => item.guid, 
                                :title => item.title, 
                                :description => helpers.truncate(helpers.strip_tags(item.description), :length => 300, :separator => ' '), 
                                :pub_time => item.pubdate.to_s(:db),
                                :link => item.link,
                                :image => image,
                                :source => feed)
                end
              end
            elsif content.match(/http:\/\/www.w3.org\/2005\/Atom/)
              puts " - Atom"
              parsed_feed = Syndication::Atom::Parser.new.parse(content)
              parsed_feed.entries.each do |entry|
                if Entry.find_by_guid entry.id
                  puts "    Exiting, matched GUID"
                  break
                else
                  puts "  New entry: #{entry.id}"
                  image = parsed_feed.icon
                  if image.nil? and description_image = entry.content.xml.match(/<img.*?src=['"](.*?)['"]/)
                    image = description_image[1]
                  end
                  Entry.create( :guid => entry.id, 
                                :title => entry.title.txt, 
                                :description => helpers.truncate(helpers.strip_tags(entry.content.xml), :length => 300, :separator => ' '),
                                :pub_time => entry.published.to_s(:db),
                                :link => entry.links.find { |l| l.type.match(/html/) and l.rel.match(/alternate/) }.href,
                                :image => image,
                                :source => feed)
                end
              end
            end

            # remove any previous errors after a successful run
            feed.update_attribute :last_error, nil
          rescue => e
            puts "   !!!! ERROR: #{e.inspect}"
            feed.update_attribute :last_error, [e, e.backtrace].flatten.join("\n")
          end
          
          feed.update_attribute :last_checked_at, Time.now
        end

      end # self.run

    end   # class
  end     # module
end       # module
