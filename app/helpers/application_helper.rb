module ApplicationHelper

  def auto_link(text, source)
    output = text
    case source
    when Tweet
      output.gsub!(/([^&]?)#(\w*)(\W|$)/, "\\1<a href=\"https://twitter.com/#!/search?q=%23\\2\">#\\2</a>\\3")
      output.gsub!(/@(\w*)(\W|$)/, "<a href=\"https://twitter.com/#!/\\1\">@\\1</a>\\2")
    end
    output = Rinku.auto_link(output)
  end


  def twitter_user_url(username)
    "https://twitter.com/#!/#{username.gsub(/@/,'')}"
  end


  def twitter_search_url(search_term)
    "https://twitter.com/#!/search?q=#{search_term}"
  end


  def google_user_url(user_id)
    "https://plus.google.com/u/0/#{user_id}"
  end


  def google_search_url(search_term)
    "https://plus.google.com/u/0/s/#{search_term}"
  end


  # the proper HTML id/name for a checkbox to show/hide a feed
  def feed_check_box_name(obj)
    obj.class.to_s.downcase + '_' + obj.id.to_s
  end

end
