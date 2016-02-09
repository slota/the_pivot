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

  test "registered user views homepage" do 
    registered_user = create(:user, role: 0)
    business_admin = create(:user, role: 0)
    venue = create(:venue, user: business_admin, status: 1)
    concert = create(:concert)
    venue.concerts << concert

    ApplicationController.any_instance.stubs(:current_user).returns(registered_user)

    visit root_path

    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
  end

  test "registered user views venue show page" do 
    registered_user = create(:user, role: 0)
    business_admin = create(:user, role: 0)
    venue = create(:venue, user: business_admin, status: 1)
    concert = create(:concert)
    venue.concerts << concert

    ApplicationController.any_instance.stubs(:current_user).returns(registered_user)
    
    visit venue_path(venue.url)

    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
    refute page.has_content?("Edit")
    refute page.has_content?("Remove")
    refute page.has_content?("Add an Admin")

  end 

  test "registered user views venue_concert show page" do 
    registered_user = create(:user, role: 0)
    business_admin = create(:user, role: 0)
    venue = create(:venue, user: business_admin, status: 1)
    concert = create(:concert)
    venue.concerts << concert

    ApplicationController.any_instance.stubs(:current_user).returns(registered_user)

    visit venue_concert_path(venue.url, concert.url)

    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
    assert page.has_content?("Quantity")
    refute page.has_content?("Edit")
    refute page.has_content?("Remove")
  end 
end
