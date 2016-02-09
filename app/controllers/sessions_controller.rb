class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.username}"
      if current_user.platform_admin?
        redirect_to admin_user_path(@user)
      else
        redirect_to user_path(@user)
      end
    else
      flash.now[:error] = "Invalid Login. Try Again."
      render :new
    end
  end

  def destroy
    flash[:notice] = "#{current_user.username} successfully logged out"
    session.clear
    redirect_to root_path
  end
end
