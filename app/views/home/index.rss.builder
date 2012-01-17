xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title       'Feeds for Woodworkers'
    xml.link        index_url(:format => :rss)
    xml.description 'Pulling together the latest in woodworking blogs, tweets, newsletters and more...'

    @entries.each do |entry|
      xml.item do
        xml.title       entry.title
        xml.link        entry.link
        xml.description entry.description
        xml.guid        entry.guid
        xml.pubDate     entry.pub_time
      end
    end
  end
end
