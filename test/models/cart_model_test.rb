require 'test_helper'

class CartModelTest < ActionDispatch::IntegrationTest
  attr_reader :cart, :concert

  def setup
    @concert = create(:concert)
    @cart = Cart.new({"#{concert.id}"=>"2"})
  end

  test 'initialize' do
    assert setup
  end

  test 'clear' do
    setup
    @cart.clear
    assert @cart.contents.empty?
  end

  test 'cart_concerts' do
    assert_equal "2", cart.cart_concerts.first.quantity
    assert_equal concert.id, cart.cart_concerts.first.id
    assert_equal concert.url, "2016-02-04-john-slota-band"
    assert_equal concert.band, "John Slota Band"
    assert_equal concert.price, cart.cart_concerts.first.price
  end

  test 'total' do
    assert_equal cart.total, concert.price * 2
  end

  test 'add_concert' do
    assert_equal 2, cart.add_concert(concert.id, 2)
  end

  test 'cart_size' do
    assert_equal 2, cart.cart_size
  end

  test 'remove_concert' do
    setup
    @cart = @cart.remove_concert_completely(concert.id)
    assert_equal "2", @cart
  end
end
