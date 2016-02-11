require 'test_helper'

class GuestAuthorizationTest < ActionDispatch::IntegrationTest
  test "guest can login" do
    venue = create(:venue)
    concert = create(:concert)
    venue.concerts << concert

    visit new_user_path
    assert_equal new_user_path, current_path

    fill_in "user[username]", with: "SteveAustin316@hotmail.com"
    fill_in "user[password]", with: "316"

    within('form') do
      click_on("Create Account")
    end

    assert_equal user_path(User.last.id), current_path
    assert page.has_content?("SteveAustin316@hotmail.com")
    assert page.has_content?("Completed Orders")

    refute page.has_content?("Manage Venues")
    refute page.has_content?("Manage Orders")
  end

  test "guest views homepage" do
    venue = create(:venue, status: 1)
    concert = create(:concert)
    venue.concerts << concert

    visit root_path

    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
  end

  test "guest views venue show page" do
    user = create(:user, role: 1)
    venue = create(:venue, status: 1, user_id: user.id)
    concert = create(:concert, venue: venue)
    venue.concerts << concert

    visit venue_path(venue.url)

    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
    refute page.has_content?("Edit")
    refute page.has_content?("Remove")
    refute page.has_content?("Add an Admin")

  end

  test "guest views venue_concert show page" do
    venue = create(:venue)
    concert = create(:concert, venue: venue)
    venue.concerts << concert

    visit venue_concert_path(venue.url, concert.url)

    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
    assert page.has_content?("Quantity")
    refute page.has_content?("Edit")
    refute page.has_content?("Remove")
  end

  test "unknown guest can't log in" do
    venue = create(:venue)
    concert = create(:concert, venue: venue)
    venue.concerts << concert

    visit root_path

    within (".right") do
      click_on("Login")
    end

    fill_in "session[username]", with: "SteveAustin316@hotmail.com"
    fill_in "session[password]", with: "316"

    within (".login") do
      click_on("Login")
    end

    assert page.has_content?("Invalid Login. Try Again.")
  end
end
