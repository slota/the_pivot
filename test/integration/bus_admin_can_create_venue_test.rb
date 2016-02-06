require 'test_helper'

class BusAdminCanCreateVenueTest < ActionDispatch::IntegrationTest
  test 'business admin can create venue' do
    venue_1, venue_2 = create_list(:venue, 2)
    business_user = create(:user, role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(business_user)

    visit user_path(business_user.id)

    click_on("Manage Venues")

    assert_equal venues_path, current_path

    save_and_open_page
    click_on("Add a Venue")

    assert_equal new_venue_path, current_path

    fill_in "venue[name]", with: "Steve's Venue"
    fill_in "venue[city]", with: "Milwaukee!!!"
    fill_in "venue[state]", with: "Wisconsin"
    fill_in "venue[address]", with: "123 street"
    fill_in "venue[description]", with: "Steve's Venue"

    click_on("Submit Venue")

    assert_equal venues_path, current_path
    assert page.has_content? ("Request sent for approval")
  end
end
