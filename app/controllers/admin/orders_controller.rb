class Admin::OrdersController < Admin::BaseController
  def index
    @order_status = params[:scope]
    @orders = Order.scope_action(@order_status).desc_by_date
  end

  def update
    @order = Order.find(params[:id])
    @order.status_update(params[:new_status])
    if @order.save
      redirect_to dashboard_path
    else
      # something
    end
  end
end
