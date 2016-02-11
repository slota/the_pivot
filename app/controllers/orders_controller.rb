class OrdersController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :require_current_user

  def index
    @user = current_user
    @orders = @user.orders.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    if @cart.contents.empty?
      flash[:error] = "Cart cannot be empty at checkout."
      redirect_to root_path
    else
      @order = Order.new
      @total = @cart.total
    end
  end

  def create
    @order = Order.new(user_id: current_user.id,
                       total_price: params[:order][:total_price],
                       address: params[:order][:address])
    @order_completion = CompleteOrder.new(@order, @cart)
    if @order_completion.create_order
      flash[:notice] = "Order was successfully placed"
      redirect_to notification_path(address: params[:order][:address])
    else
      flash[:notice] = "There was an error with your order, please try agin"
      redirect_to root_path
    end
  end
end
