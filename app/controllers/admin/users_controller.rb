class Admin::UsersController < Admin::BaseController
  def show
    @user = current_user
    @orders = @user.orders.all
  end
end
