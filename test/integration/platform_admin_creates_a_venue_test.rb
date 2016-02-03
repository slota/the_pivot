require 'test_helper'

class PlatformAdminCreatesAVenueTest < ActionDispatch::IntegrationTest
  test "plaform admin creates a venue" do 
    platform_admin = User.create(username: "steve@gmail.com",
                                 password: "password",
                                 role: 2)
    ApplicationController.any_instance.stubs(:current_user).returns(platform_admin)

    visit admin_venues_path
    assert_equal admin_venues_path, current_path


    click_on "Add a Venue"

    assert_equal new_admin_venue_path, current_path

    fill_in :name, with: "Red Rocks"
    fill_in :background_image, with: "http://theredrocksamphitheater.com/wp-content/uploads/2014/11/redrocks3.jpg"
    fill_in :city, with: "Morrison"
    fill_in :state, with: "Colorado"
    fill_in :address, with: "18300 W Alameda Pkwy"

    click_on "Submit Venue"

    assert page.has_content?("Thank you for your submission. Your venue will be activated once we review your submission!")

    assert_equal admin_dashboard_path, current_path

    assert page.has_content?("Red Rocks")
    assert page.has_content?("Pending")
    assert page.has_content?("Approve Venue")

    click_on "Approve Venue"

    assert_equal admin_dashboard_path, current_path

    click_on "View All Venues"

    assert page.has_content?("Red Rocks")
    assert page.has_content?("Active")

    click_on "Red Rocks"

    assert_equal "/admin/red-rocks", current_path

    assert page.has_content?("Red Rocks")
    assert page.has_content?("Status")
    assert page.has_content?("Active")
    assert page.has_content?("Edit")
  end 
end
