class HomeController < ApplicationController

  skip_before_filter :login_required

  def index
    @entries = Entry.latest(params[:num] || 25).includes(:source)
  end

end
