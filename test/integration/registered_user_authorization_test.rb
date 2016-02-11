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

    assert page.has_content?("Logged in as #{user.username}")
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

  test "registered user cannot access platform admin page" do
    reg_user = create(:user, role: 0)
    venue = create(:venue, user: reg_user, status: 1)
    concert = create(:concert)
    venue.concerts << concert

    ApplicationController.any_instance.stubs(:current_user).returns(reg_user)

    visit admin_user_path(reg_user)
    assert page.has_content?("Access denied, sucker!")
    assert current_path, root_path

  end

  test "registered user cannot make two of the same accounts" do
    user = create(:user)
    venue = create(:venue)
    concert = create(:concert)
    venue.concerts << concert

    visit root_path
    assert_equal current_path, root_path

    within('.right') do
      click_on("Create Account")
    end

    fill_in "user[username]", with: user.username
    fill_in "user[password]", with: user.password

    within('.new_user') do
      click_on("Create Account")
    end

    assert page.has_content?("Username has already been taken")
  end

  test "registered user cannot update username with nothing" do
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

    assert page.has_content?("Logged in as #{user.username}")
    assert page.has_content?(user.username)
    assert page.has_content?("Completed Orders")
    refute page.has_content?("Manage Venues")
    refute page.has_content?("Manage Orders")

    click_on("Edit Profile")

    fill_in "user[username]", with: nil

    click_on("Update Account")

    assert page.has_content?("Username can't be blank")
  end
end
