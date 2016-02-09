require 'test_helper'

class RegisteredUserAuthorizationTest < ActionDispatch::IntegrationTest
  test "registered user can login" do 
    user = create(:user)
    venue = create(:venue)
    concert = create(:concert)
    venue.concerts << concert

    visit login_path
    assert_equal login_path, current_path

    fill_in "session[username]", with: user.username
    fill_in "session[password]", with: user.password

    within('form') do
      click_on("Login")
    end

    assert_equal user_path(user), current_path
    assert page.has_content?(user.username)
    assert page.has_content?("Completed Orders")
    refute page.has_content?("Manage Venues")
    refute page.has_content?("Manage Orders")
  end 

  # test "guest views homepage" do 
  #   venue = create(:venue)
  #   concert = create(:concert)
  #   venue.concerts << concert

  #   visit root_path

  #   assert page.has_content?(venue.name)
  #   assert page.has_content?(concert.band)
  # end

  # test "guest views venue show page" do 
  #   venue = create(:venue)
  #   concert = create(:concert, venue: venue)
  #   venue.concerts << concert

  #   visit venue_path(venue.url)

  #   assert page.has_content?(venue.name)
  #   assert page.has_content?(concert.band)
  #   refute page.has_content?("Edit")
  #   refute page.has_content?("Remove")
  #   refute page.has_content?("Add an Admin")

  # end 

  # test "guest views venue_concert show page" do 
  #   venue = create(:venue)
  #   concert = create(:concert, venue: venue)
  #   venue.concerts << concert

  #   visit venue_concert_path(venue.url, concert.url)

  #   assert page.has_content?(venue.name)
  #   assert page.has_content?(concert.band)
  #   assert page.has_content?("Quantity")
  #   refute page.has_content?("Edit")
  #   refute page.has_content?("Remove")
  # end 
end
