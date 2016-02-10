require 'test_helper'

class ConcertModelTest < ActionDispatch::IntegrationTest
  test 'initialize' do
    concert = create(:concert)
    cart_concert = CartConcert.new(concert, 2, 10)
    assert_equal concert.band, cart_concert.band
    assert_equal concert.price, cart_concert.price
    assert_equal concert.url, cart_concert.url
  end
end
