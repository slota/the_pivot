require 'test_helper'

class BusinessAdminManageConcertsTest < ActionDispatch::IntegrationTest
  test "business admin adds concerts" do
    user = create(:user, role:1)
    venue = create(:venue)
    user.venues << venue
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit venue_path(venue.url)

    refute page.has_content?("Add an Admin")

    click_on "Add a concert"

    assert_equal venue_new_concert_path(venue.url), current_path
    fill_in 'concert[date]', with: Time.new
    fill_in 'concert[band]', with: 'The Supersonics'
    fill_in 'concert[price]', with: 250
    fill_in 'concert[genre]', with: 'Rock'
    click_on "Create Concert"

    assert_equal venue_path(venue.url), current_path

    assert page.has_content?('The Supersonics')
  end
end
