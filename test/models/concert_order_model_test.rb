require 'test_helper'

class ConcertOrderModelTest < ActionDispatch::IntegrationTest
  def setup
    @concert = create(:concert)
    @order = create(:order)
    @cart = Cart.new({"#{@concert.id}"=>"2"})
    ConcertOrder.create_concert_order(@order, @cart)
  end

  test 'create concert order' do
    assert_equal ConcertOrder.first.concert_id, @concert.id
    assert_equal ConcertOrder.first.order_id, @order.id
    assert_equal ConcertOrder.first.subtotal, @concert.price * @cart.contents.values.first.to_i
    assert_equal ConcertOrder.first.quantity, @cart.contents.values.first.to_i
  end
end
