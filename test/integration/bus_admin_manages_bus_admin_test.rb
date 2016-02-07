require 'test_helper'

class BusAdminManagesBusAdminTest < ActionDispatch::IntegrationTest
  test "business admin can edit themselves" do
    business_user = create(:user)
    business_user.update(role: 1)
    venue = create(:venue)
    venue.update(user_id: business_user.id)
    ApplicationController.any_instance.stubs(:current_user).returns(business_user)

    visit root_path
    visit user_path(business_user)
    click_link "Manage Venues"

    assert page.has_content?(venue.name)

    assert current_path, venues_path

    click_link("Manage Venue")

    assert current_path, venue_path(venue)

    click_link("edit")

    fill_in "user[username]", with: "jesus"

    click_on("Update Account")

    assert current_path, user_path(business_user)

  end
end
