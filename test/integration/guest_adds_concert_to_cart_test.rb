require 'test_helper'

class GuestAddsConcertToCartTest < ActionDispatch::IntegrationTest
  test "registered guest adds concert to cart" do
    venue = create(:venue)
    concert = create(:concert, venue: venue)
    registered_user = create(:user, role: 0)
    ApplicationController.any_instance.stubs(:current_user).returns(registered_user)

    visit venue_concert_path(concert.venue.url, concert.url)
    assert_equal venue_concert_path(concert.venue.url, concert.url), current_path

    assert page.has_content?(concert.date)
    assert page.has_content?("Logo")
    assert page.has_content?(concert.band)
    assert page.has_content?(concert.venue.name)
    assert page.has_content?(concert.price)
    assert page.has_content?("Quantity")

    fill_in "order[quantity]", with: 2

    click_button("Add to Cart")

    assert_equal cart_path, current_path

    assert page.has_content?(concert.date)
    assert page.has_content?("Logo")
    assert page.has_content?(concert.band)
    assert page.has_content?(concert.venue.name)
    assert page.has_content?(concert.price)
    assert page.has_content?("Quantity")
    assert page.has_content?(concert.price)

    assert page.has_content?("2")
    assert page.has_content?("#{concert.price * 2}")
    assert page.has_content?("Checkout!")
  end

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

    fill_in "order[quantity]", with: 2

    click_button("Add to Cart")

    assert_equal cart_path, current_path

    assert page.has_content?(concert.date)
    assert page.has_content?("Logo")
    assert page.has_content?(concert.band)
    assert page.has_content?(concert.venue.name)
    assert page.has_content?(concert.price)
    assert page.has_content?("Quantity")
    assert page.has_content?(concert.price)

    assert page.has_content?("2")
    assert page.has_content?("#{concert.price * 2}")
    assert page.has_content?("Checkout!")
  end

  test "unregistered guest is asked to log in" do
    venue = create(:venue)
    concert = create(:concert, venue: venue)

    visit root_path

    assert_equal current_path, root_path

    within ('.right') do
      click_link("Cart")
    end

    assert_equal current_path, cart_path


    assert page.has_content?("Don't have an account?")

    click_link("Checkout!")
    assert page.has_content?("Create one here")
  end

  test "registered guest can purchase tickets" do
    venue = create(:venue)
    concert = create(:concert, venue: venue)
    registered_user = create(:user, role: 0)
    ApplicationController.any_instance.stubs(:current_user).returns(registered_user)

    visit venue_concert_path(concert.venue.url, concert.url)
    assert_equal venue_concert_path(concert.venue.url, concert.url), current_path

    assert page.has_content?(concert.date)
    assert page.has_content?("Logo")
    assert page.has_content?(concert.band)
    assert page.has_content?(concert.venue.name)
    assert page.has_content?(concert.price)
    assert page.has_content?("Quantity")

    fill_in "order[quantity]", with: 2

    click_button("Add to Cart")

    assert_equal cart_path, current_path

    assert page.has_content?(concert.date)
    assert page.has_content?("Logo")
    assert page.has_content?(concert.band)
    assert page.has_content?(concert.venue.name)
    assert page.has_content?(concert.price)
    assert page.has_content?("Quantity")
    assert page.has_content?(concert.price)

    assert page.has_content?("2")
    assert page.has_content?("#{concert.price * 2}")
    assert page.has_content?("Checkout!")

    click_link ("Checkout!")
    assert_equal current_path, new_order_path

    assert page.has_content?("Address")
    assert page.has_content?("Checkout")

    fill_in "order[address]", with: "321 street"
    click_button("Checkout")

    assert page.has_content?("Order was successfully placed")

  end
end
