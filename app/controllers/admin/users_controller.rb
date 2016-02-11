class Admin::UsersController < ApplicationController
  def show
    @user = current_user
    @orders = @user.orders.all
  end
end
