require 'test_helper'

class BusinessAdminAuthorizationTest < ActionDispatch::IntegrationTest
  attr_accessor :business_admin, :venue, :concert
  
  def setup_factories
    @business_admin = create(:user, role: 1)
    @venue = create(:venue, user: @business_admin, status: 1)
    @concert = create(:concert)
    @venue.concerts << concert
  end 

  test "business admin can login" do 
    setup_factories

    visit login_path
    assert_equal login_path, current_path

    fill_in "session[username]", with: business_admin.username
    fill_in "session[password]", with: business_admin.password

    within('form') do
      click_on("Login")
    end

    assert_equal user_path(business_admin), current_path

    assert page.has_content?(business_admin.username)
    assert page.has_content?("Completed Orders")
    assert page.has_content?("Manage Venues")
  end
  
  test "business admin views homepage" do 
    setup_factories

    ApplicationController.any_instance.stubs(:current_user).returns(business_admin)

    visit root_path

    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
  end

  test "registered user views venue show page" do 
    setup_factories

    ApplicationController.any_instance.stubs(:current_user).returns(business_admin)
    
    visit venue_path(venue.url)

    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
    assert page.has_content?("Edit")
    assert page.has_content?("Remove")
    assert page.has_content?("Add an Admin")
  end 

  test "business admin views venue_concert show page" do 
    setup_factories

    ApplicationController.any_instance.stubs(:current_user).returns(business_admin)

    visit venue_concert_path(venue.url, concert.url)

    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
    assert page.has_content?("Quantity")
  end 

  test "business admin can edit concert" do 
    setup_factories

    ApplicationController.any_instance.stubs(:current_user).returns(business_admin)

    visit venue_path(venue.url)

    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
    assert page.has_content?("Edit")
    assert page.has_content?("Remove")
    within('.concert-venue') do 
      click_on("Edit")
    end

    fill_in "concert[band]", with: "Ja Rule"
    fill_in "concert[price]", with: 45
    fill_in "concert[genre]", with: "Rap"
    click_on "Update Concert"

    assert_equal venue_path(venue.url), current_path
    assert page.has_content?("Ja Rule")
  end

  test "business admin can remove concert" do 
    setup_factories

    ApplicationController.any_instance.stubs(:current_user).returns(business_admin)

    visit venue_path(venue.url)

    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
    assert page.has_content?("Edit")
    assert page.has_content?("Remove")
    
    within('.concert-venue') do 
      click_on("Remove")
    end

    assert_equal venue_path(venue.url), current_path
    refute page.has_content?(concert.band)
    refute page.has_content?(concert.date)
    refute page.has_content?(concert.logo)
  end 

  test "business admin can only manage venues they own" do 
    setup_factories
    business_admin_visitor = create(:user, role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(business_admin_visitor)

    visit venue_path(venue.url)

    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
    refute page.has_content?("Edit")
    refute page.has_content?("Remove")
  end 

  test "business admin can only manage concerts for venues they own" do 
    setup_factories
    business_admin_visitor = create(:user, role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(business_admin_visitor)

    visit venue_path(venue.url)
    click_on(concert.band)
    assert page.has_content?(venue.name)
    assert page.has_content?(concert.band)
    refute page.has_content?("Edit")
    refute page.has_content?("Remove")
  end 

end
