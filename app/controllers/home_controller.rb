class HomeController < ApplicationController

  skip_before_filter :login_required

  def index
    @entries = Entry.latest(25)
  end

end
