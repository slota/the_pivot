require 'test_helper'

class BusinessAdminRemovesConcertTest < ActionDispatch::IntegrationTest
  test "business admin removes concert" do 
    user = create(:user, role: 1)
    venue = create(:venue, user_id: user.id)
    concert = create(:concert, venue_id: venue.id)
    
    visit venue_path(venue.url)

    assert page.has_content?(concert.band)
    assert page.has_content?(concert.date)
    assert page.has_content?("remove")

    click_on("remove")

    assert_equal venue_path(venue.url), current_path
    refute page.has_content?(concert.band)
    refute page.has_content?(concert.date)
  end
end
