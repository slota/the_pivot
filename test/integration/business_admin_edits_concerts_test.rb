require 'test_helper'

class BusinessAdminEditsConcertsTest < ActionDispatch::IntegrationTest
  test "business admin adds concerts" do
    user = create(:user, role:1)
    venue = create(:venue)
    concert = create(:concert)
    user.venues << venue
    venue.concerts << concert
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit venue_path(venue.url)
    # save_and_open_page
    click_on "edit"

    assert_equal venue_edit_concert_path(venue.url), current_path
    fill_in 'concert[band]', with: 'Gigatron'
    click_on "Update Concert"

    assert_equal venue_path(venue.url), current_path

    assert page.has_content? 'Gigatron'
  end
end
