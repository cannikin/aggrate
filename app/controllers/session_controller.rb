class SessionController < ApplicationController
  
  skip_before_filter :login_required

  layout 'admin'

  def new
    
  end

  def create
    if user = User.authenticate(params[:user][:username], params[:user][:password])
      log_in_user(user)
      redirect_to admin_url
    else
      flash[:notice] = "Username or password not found, try again."
      render :new
    end
  end

  def destroy
    log_out_user
    redirect_to root_path
  end
end
