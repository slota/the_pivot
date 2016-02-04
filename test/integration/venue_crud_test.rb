require 'test_helper'

class VenueCrudTest < ActionDispatch::IntegrationTest
  test "business_admin sees (only) their venues" do
    venue_1, venue_2, venue_3 = create_list(:venue, 3)
    business_admin = create(:user, role: 1, venues: [ venue_1, venue_2 ])
    ApplicationController.any_instance.stubs(:current_user).returns(business_admin)

    visit venues_path
    assert page.has_content? venue_1.name
    assert page.has_content? venue_2.name
    refute page.has_content? venue_3.name
  end

  test "platform_admin sees (only) their venues" do
    venue_1, venue_2, venue_3 = create_list(:venue, 3)
    platform_admin = create(:user, role: 1, venues: [ venue_1, venue_2 ])
    ApplicationController.any_instance.stubs(:current_user).returns(platform_admin)

    visit venues_path
    assert page.has_content? venue_1.name
    assert page.has_content? venue_2.name
    refute page.has_content? venue_3.name
  end

  test "registered_user gets a 404 for venues" do
    user = create(:user, role: 0)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit venues_path
    assert page.has_content? "The page you were looking for doesn't exist"
  end

  test "plaform admin creates a venue" do
    skip
    platform_admin = create(:user, role: 2)
    ApplicationController.any_instance.stubs(:current_user).returns(platform_admin)

    visit admin_venues_path
    assert_equal admin_venues_path, current_path
    click_on "Add a Venue"

    assert_equal new_admin_venue_path, current_path

    fill_in "venue[name]", with: "Red Rocks"
    # fill_in :background_image, with: "http://theredrocksamphitheater.com/wp-content/uploads/2014/11/redrocks3.jpg"
    fill_in "venue[city]", with: "Morrison"
    fill_in "venue[state]", with: "Colorado"
    fill_in "venue[address]", with: "18300 W Alameda Pkwy"
    fill_in "venue[description]", with: "Amphitheatre"

    click_on "Submit Venue"

    assert page.has_content?("Thank you for your submission. Your venue will be activated once we review your submission!")

    assert_equal admin_venues_path, current_path

    assert page.has_content?("Pending")
    assert page.has_content?("Approve Venue")
  end

  test "guest gets a 404 for venues" do
    visit venues_path
    assert page.has_content? "The page you were looking for doesn't exist"
  end

  test "platform_admin creates venue" do
  end

  test "registered_user cannot create venue" do
  end

  test "guest_user cannot create venue" do
  end
end
