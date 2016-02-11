class CompleteOrder
  attr_accessor :order, :cart

  def initialize(order, cart)
    @order = order
    @cart = cart
  end

  def create_order
    if @order.save
      create_concert_order
      clear_cart
    end
  end

  def create_concert_order
    ConcertOrder.create_concert_order(@order, @cart)
  end

  def clear_cart
    @cart.contents.clear
  end
end
