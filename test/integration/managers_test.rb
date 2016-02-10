require 'test_helper'

class ManagersTest < ActionDispatch::IntegrationTest
  test "managers can be added" do
    manager = create(:user, role: 0)
    owner = create(:user, role: 1)
    venue = create(:venue, user: owner)
    ApplicationController.any_instance.stubs(:current_user).returns(owner)

    visit venue_path(venue.url)

    fill_in "new_manager", with: manager.username
    click_on "Add as manager"

    assert_equal venue_path(venue.url), current_path
    assert page.has_content?(manager.username)
    assert_equal venue.users.count, 1
  end

  test "managers can be removed" do
    manager = create(:user, role: 0)
    owner = create(:user, role: 1)
    venue = create(:venue, user: owner, users:[manager])
    ApplicationController.any_instance.stubs(:current_user).returns(owner)

    visit venue_path(venue.url)
    assert page.has_content?(manager.username)

    click_on "remove"

    assert_equal venue_path(venue.url), current_path
    refute page.has_content?(manager.username)
    assert_equal venue.users.count, 0
  end

  test "managers can add other managers" do
    manager = create(:user, role: 1)
    user = create(:user, role: 0)

    # manager, user = create_list(:user, 2, role: 0)
    venue = create(:venue, users:[manager])
    ApplicationController.any_instance.stubs(:current_user).returns(manager)
    # binding.pry
    assert_equal venue.users.count, 1
    visit venue_path(venue.url)
    # save_and_open_page
    fill_in "new_manager", with: user.username
    click_on "Add as manager"

    assert_equal venue_path(venue.url), current_path
    assert page.has_content?(manager.username)
    assert_equal venue.users.count, 2
  end

  test "managers can add other concerts" do
    manager = create(:user, role: 1)
    venue = create(:venue, users:[manager])
    ApplicationController.any_instance.stubs(:current_user).returns(manager)

    visit venue_path(venue.url)
    click_on "Add a concert"

    assert_equal venue_new_concert_path(venue.url), current_path
    # save_and_open_page
    fill_in "concert[band]", with: "Gigatron"
    click_on "Create Concert"

    assert_equal venue_path(venue.url), current_path
    assert page.has_content?("Gigatron")
  end
end
