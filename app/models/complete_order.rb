class CompleteOrder
  attr_accessor :order

  def initialize(order, cart)
    @order = order
    @cart = cart
  end

  def create_order
    if @order.save
      create_concert_order
      clear_cart
    else
      # something else
    end
  end

  def create_concert_order
    ChipOrder.create_concert_order(@order, @cart)
  end

  def clear_cart
    @cart.contents.clear
  end
end
