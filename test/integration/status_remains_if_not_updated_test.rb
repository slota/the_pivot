require 'test_helper'

class StatusRemainsIfNotUpdatedTest < ActionDispatch::IntegrationTest
  test 'status remains pending if not updated' do
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

    click_on("Update Venue")

    assert current_path, admin_venues_path

    assert page.has_content?("#{venue.name} Updated!")
    assert page.has_content?("Pending")
  end
  test 'status remains unchanged if not updated' do
    user = create(:user,role: 2)
    user_2 = create(:user)
    venue = create(:venue, user_id: user_2.id, status: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_venues_path

    assert current_path, admin_venues_path
    assert page.has_content?(venue.name)
    assert page.has_content?("Approved")

    click_on("Approved")

    assert current_path, edit_admin_venue_path(venue)
    click_on("Update Venue")

    assert current_path, admin_venues_path

    assert page.has_content?("#{venue.name} Updated!")
    assert page.has_content?("Approved")
  end
end
