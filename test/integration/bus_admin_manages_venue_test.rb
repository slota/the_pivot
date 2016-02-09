require 'test_helper'

class BusAdminManagesVenueTest < ActionDispatch::IntegrationTest
  test 'business admin can create venue' do
    business_user = create(:user, role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(business_user)

    visit user_path(business_user.id)

    click_on("Manage Venues")

    assert_equal venues_path, current_path

    click_on("Add a Venue")

    assert_equal new_venue_path, current_path

    fill_in "venue[name]", with: "Steve's Venue"
    fill_in "venue[city]", with: "Milwaukee!!!"
    fill_in "venue[state]", with: "Wisconsin"
    fill_in "venue[address]", with: "123 street"
    fill_in "venue[description]", with: "Steve's Venue"

    click_on("Create Venue")

    assert_equal venues_path, current_path
    assert page.has_content? ("Request sent for approval")
  end

  test 'business admin can edit venue' do
    venue_1 = create(:venue)
    business_user = create(:user, role: 1)
    venue_1.update_attributes(user_id: business_user.id)
    venue_1.reload
    ApplicationController.any_instance.stubs(:current_user).returns(business_user)
    # venue_2.update_attributes(user_id: business_user.id)
    visit venues_path

    assert_equal venues_path, current_path

    assert page.has_content?(venue_1.name)

    click_on "edit"
    assert_equal edit_venue_path(venue_1.url), current_path
    fill_in "name", with: "Steve's Venue"
    fill_in "city", with: "Milwaukee!!!"
    fill_in "state", with: "Wisconsin"
    fill_in "address", with: "123 street"
    fill_in "description", with: "Steve's Venue 3"

    click_on("Update Venue")
    assert_equal venues_path, current_path
    assert page.has_content?("Steve's Venue Updated!")
    assert page.has_content?("Steve's Venue")
    # venue_1.reload
    # assert page.has_content?(venue_1.address)
  end
end
