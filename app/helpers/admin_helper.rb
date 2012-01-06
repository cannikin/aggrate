module AdminHelper

  def error_note(thing)
    unless thing.last_error.nil?
      error = thing.last_error.split("\n")
      content_tag('span', 'Error', { :class => 'label important', :rel => 'popover', :'data-original-title' => error.first, :'data-content' => error[1,4] })
    end
  end

end
