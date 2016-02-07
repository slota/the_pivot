require 'test_helper'

class BusinessAdminRemovesConcertTest < ActionDispatch::IntegrationTest
  test "business admin removes concert" do
    user = create(:user, role: 1)
    venue = create(:venue, user_id: user.id)
    concert = create(:concert, venue_id: venue.id)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit venue_path(venue.url)

    assert page.has_content?(concert.band)
    assert page.has_content?(concert.date)
    assert page.has_content?("Remove")

    click_on("Remove")

    assert_equal venue_path(venue.url), current_path
    refute page.has_content?(concert.band)
    refute page.has_content?(concert.date)
  end
end
