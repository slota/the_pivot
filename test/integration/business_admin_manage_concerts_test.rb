require 'test_helper'

class BusinessAdminManageConcertsTest < ActionDispatch::IntegrationTest
  test "business admin adds concerts" do
    category = create(:category)
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
    fill_in 'concert[genre]', with: category.description.upcase
    click_on "Create Concert"

    assert_equal venue_path(venue.url), current_path
    concert = Concert.last
    assert page.has_content?('The Supersonics')
    assert_equal concert.category.description, category.description
  end

  test "business admin cannot add concerts with wrong genre" do
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
    fill_in 'concert[genre]', with: 'climbing'
    click_on "Create Concert"

    assert_equal venue_new_concert_path(venue.url), current_path
    assert_equal Concert.count, 0
    assert page.has_content?('Introduce a valid genre')
  end
end
