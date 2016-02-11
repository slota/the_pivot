require 'test_helper'

class PlatformAdminAddsConcertTest < ActionDispatch::IntegrationTest
  test 'platform admin logs in and adds a concert to venue' do
    user = create(:user, role: 2)
    venue = create(:venue)

    visit root_path
    within ".right" do
      click_link "Login"
    end

    fill_in "Username", with: user.username
    fill_in "Password", with: "pass"
    click_button "Login"

    assert_equal admin_user_path(user), current_path

    click_on("Manage Venues")

    assert page.has_content?(venue.name)

    assert current_path, admin_venues_path

    click_on("Manage")

    assert current_path, admin_venue_path(venue)

    click_link("Add a concert")

    assert current_path, new_admin_concert_path

    fill_in 'concert[date]', with: Time.new
    fill_in 'concert[band]', with: 'The Supersonics'
    fill_in 'concert[price]', with: 250
    fill_in 'concert[genre]', with: 'Rock'
    click_on "Create Concert"

    assert_equal current_path, admin_venue_path(venue.url)
    assert page.has_content?("The Supersonics")
  end

  test "platform admin removes concert" do
    user = create(:user, role: 2)
    venue = create(:venue, user_id: user.id)
    concert = create(:concert, venue_id: venue.id)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_venue_path(venue.url)

    assert page.has_content?(concert.band)
    assert page.has_content?(concert.date)
    assert page.has_content?("remove")

    click_on("remove")

    assert_equal admin_venue_path(venue.url), current_path
    refute page.has_content?(concert.band)
    refute page.has_content?(concert.date)
  end

  test 'platform admin can view orders' do
    venue_1 = create(:venue)
    platform_user = create(:user, role: 2)
    venue_1.update_attributes(user_id: platform_user.id)
    concert = create(:concert, venue: venue_1)
    order = create(:order, user: platform_user)
    concert_order = create(:concert_order, concert: concert, order: order )
    venue_1.reload
    ApplicationController.any_instance.stubs(:current_user).returns(platform_user)

    visit admin_venues_path

    assert_equal admin_venues_path, current_path

    assert page.has_content?(venue_1.name)

    click_on("Manage")
    assert_equal current_path, admin_venue_path(venue_1.url)

    click_on("View Orders")

    assert page.has_content?(order.id)
    assert page.has_content?(order.total_price)
    assert page.has_content?(order.address)
  end

end
