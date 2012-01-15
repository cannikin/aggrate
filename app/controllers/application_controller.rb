class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :login_required

  helper_method :logged_in?, :current_user

  def logged_in?
    session[:user_id]
  end
  private :logged_in?


  def current_user
  end
  private :current_user


  def log_in_user(user)
    session[:user_id] = user.id
  end
  private :log_in_user


  def log_out_user
    session.clear
  end
  private :log_out_user


  def login_required
    render 'public/404.html', :layout => false unless logged_in? and return
  end
  private :login_required

end
