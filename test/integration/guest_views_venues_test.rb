require 'test_helper'

class GuestViewsVenueTest < ActionDispatch::IntegrationTest
  test "guest views venue show page from root path" do
    venue = create(:venue, status: 1)
    concert = create(:concert, venue: venue)


    visit root_path
    click_on "#{venue.name}"
    assert_equal venue_path(concert.venue.url), current_path
    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
  end
end
