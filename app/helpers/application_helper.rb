module ApplicationHelper

  def auto_link(text)
    output = text.gsub(/#(\w*)(\W|$)/, "<a href=\"https://twitter.com/#!/search?q=%23\\1\">#\\1</a>\\2")
    output = output.gsub(/@(\w*)(\W|$)/, "<a href=\"https://twitter.com/#!/\\1\">@\\1</a>\\2")
    output = Rinku.auto_link(output)
  end

  def twitter_user_url(username)
    "https://twitter.com/#!/#{username.gsub(/@/,'')}"
  end


  def twitter_search_url(search_term)
    "https://twitter.com/#!/search?q=#{search_term}"
  end


  # the proper HTML id/name for a checkbox to show/hide a feed
  def feed_check_box_name(obj)
    obj.class.to_s.downcase + '_' + obj.id.to_s
  end

end
