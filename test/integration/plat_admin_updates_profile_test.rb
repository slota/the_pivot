require "test_helper"

class PlatAdminUpdatesProfileTest < ActionDispatch::IntegrationTest
  test "registered user cannot update username with nothing" do
    user = create(:user, role: 2)
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

    assert_equal admin_user_path(user), current_path

    assert page.has_content?("Logged in as #{user.username}")
    assert page.has_content?(user.username)
    assert page.has_content?("Completed Orders")
    assert page.has_content?("Manage Venues")

    click_on("Edit Profile")

    fill_in "user[username]", with: "hola"

    click_on("Update Account")
    assert current_path, admin_user_path(user)

    assert page.has_content?("hola")
  end
end
