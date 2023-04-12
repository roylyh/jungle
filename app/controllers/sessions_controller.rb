class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.authenticate_with_credentials(params[:email], params[:password])
      # If user authenticated then set session id to create logged in status
      session[:user_id] = @user.id
      redirect_to [:root]
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to [:root]
  end
end
