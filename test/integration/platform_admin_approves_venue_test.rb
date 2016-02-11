require 'test_helper'

class PlatformAdminApprovesVenueTest < ActionDispatch::IntegrationTest
  test 'platform admin can approve' do
    user = create(:user,role: 2)
    user_2 = create(:user)
    venue = create(:venue, user_id: user_2.id)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_venues_path

    assert current_path, admin_venues_path
    assert page.has_content?(venue.name)
    assert page.has_content?("Pending")

    click_on("Pending")

    assert current_path, edit_admin_venue_path(venue)

    page.choose('Approved')
    click_on("Update Venue")

    assert current_path, admin_venues_path

    assert page.has_content?("#{venue.name} Updated!")
    assert page.has_content?("Approved")
  end
end
