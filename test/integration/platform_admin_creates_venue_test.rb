require 'test_helper'

class PlatformAdminCreatesVenueTest < ActionDispatch::IntegrationTest
  test 'platform admin can create venue' do
    user = create(:user,role: 2)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_venues_path

    assert current_path, admin_venues_path


    click_on("Add a Venue")

    assert current_path, new_admin_venue_path

    fill_in "venue[name]", with: "Steve's Venue"
    fill_in "venue[city]", with: "Milwaukee!!!"
    fill_in "venue[state]", with: "Wisconsin"
    fill_in "venue[address]", with: "123 street"
    fill_in "venue[description]", with: "Steve's Venue"
    click_on("Create Venue")

    assert current_path, admin_venues_path

    assert page.has_content?("Request sent for approval")
    assert page.has_content?("Steve's Venue")
    assert page.has_content?("Milwaukee!!!")
    assert page.has_content?("123 street")
  end

end
