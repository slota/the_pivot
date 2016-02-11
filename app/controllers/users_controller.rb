class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.username}"
      redirect_to user_path(@user)
    else
      flash.now[:error] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @user = current_user
    @orders = current_user.orders
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash.notice = "Your Account Has Been Updated!"
      check_for_redirect
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

  def check_for_redirect
    if platform_admin?
      redirect_to admin_user_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:username, :password, :image)
  end
end
