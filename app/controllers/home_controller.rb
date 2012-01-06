class HomeController < ApplicationController

  def index
    @entries = Entry.latest(25)
  end

end
