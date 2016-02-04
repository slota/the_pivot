require 'test_helper'

class GuestAddsConcertToCartTest < ActionDispatch::IntegrationTest
  test "unregistered guest adds concert to cart" do 
    venue = create(:venue)
    concert = create(:concert, venue: venue)

    visit venue_concert_path(concert.venue.url, concert.url)
    assert_equal venue_concert_path(concert.venue.url, concert.url), current_path
    
    assert page.has_content?(concert.date)
    assert page.has_content?("Logo")
    assert page.has_content?(concert.band)
    assert page.has_content?(concert.venue.name)
    assert page.has_content?(concert.price)
    assert page.has_content?("Quantity")
    assert page.has_content?("Total")
    assert page.has_content?("Add to Cart")

    fill_in "order[quantity]", with: 2
    click_on "Add to Cart"

    assert cart_path, current_path

    assert page.has_content?(concert.date)
    assert page.has_content?("Logo")
    assert page.has_content?(concert.band)
    assert page.has_content?(concert.venue.name)
    assert page.has_content?(concert.price)
    assert page.has_content?("Quantity")
    assert page.has_content?(concert.price)
    assert page.has_content?("2")
    assert page.has_content?("Checkout!")
  end 
end
