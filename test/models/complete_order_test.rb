require 'test_helper'

class CompleteOrderTest < ActionDispatch::IntegrationTest

  def setup
    @concert = create(:concert)
    order = Order.new(status: "Ordered",
                      total_price: 1.5,
                      user: nil,
                      address: "321 awesome")
    cart = Cart.new({"#{@concert.id}"=>"2"})
    @complete_order = CompleteOrder.new(order, cart)
  end

  test 'initialize' do
    setup
    assert @complete_order
  end

  test 'create order' do
    @complete_order.create_order
    assert_equal Order.first.status, "Ordered"
    assert_equal Order.first.total_price, 1.5
    assert_equal Order.first.address, "321 awesome"
  end

  test 'create concert order' do
    @complete_order.create_concert_order
    assert_equal ConcertOrder.first.quantity, 2
    assert_equal @concert.price * 2, ConcertOrder.first.subtotal
    assert_equal @concert.id, ConcertOrder.first.concert_id
  end

  test 'clear_cart' do
    @complete_order.clear_cart
    assert @complete_order.cart.contents.empty?
  end
end
