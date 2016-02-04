require 'test_helper'

class PlatformAdminCreatesAVenueTest < ActionDispatch::IntegrationTest
  test "plaform admin creates a venue" do
    skip
    platform_admin = User.create(username: "steve@gmail.com",
                                 password: "password",
                                 role: 2)
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

end
