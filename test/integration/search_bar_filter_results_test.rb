require 'test_helper'

class SearchBarFilterResultsTest < ActionDispatch::IntegrationTest
  test "guest can filter by genre" do
    genre_1 = create(:category, description: 'ska')
    genre_2 = create(:category, description: 'rock')
    venue = create(:venue, status: 1)
    concert_1 = create(:concert, category: genre_1)
    concert_2 = create(:concert, category: genre_2)
    venue.concerts << [concert_1, concert_2]

    visit root_path
    # save_and_open_page
    assert page.has_content? concert_1.band
    assert page.has_content? genre_1.description.capitalize
    assert page.has_content? concert_2.band
    assert page.has_content? genre_2.description.capitalize

    fill_in 'search[Genre]', with: genre_1.description
    find("#search",:visible=>false).click

    assert_equal search_path, current_path
    # save_and_open_page
    assert page.has_content? concert_1.band
    assert page.has_content? genre_1.description.capitalize
    refute page.has_content? concert_2.band
    refute page.has_content? genre_2.description.capitalize
  end

  test "guest can filter by city" do
    venue_1 = create(:venue, status: 1, city: 'Alicante')
    venue_2 = create(:venue, status: 1, city: 'Denver')
    concert_1 = create(:concert, venue: venue_1)
    concert_2 = create(:concert, venue: venue_2)

    visit root_path

    assert page.has_content? concert_1.band
    assert page.has_content? concert_2.band

    fill_in 'search[City]', with: venue_1.city
    find("#search",:visible=>false).click

    assert_equal search_path, current_path

    assert page.has_content? concert_1.band
    refute page.has_content? concert_2.band
  end

  test "guest can filter by date" do
    venue = create(:venue, status: 1)
    concert_1 = create(:concert, venue: venue)
    concert_2 = create(:concert, venue: venue)

    visit root_path

    assert page.has_content? concert_1.band
    assert page.has_content? concert_2.band

    fill_in 'search[Date]', with: concert_1.date
    find("#search",:visible=>false).click

    assert_equal search_path, current_path

    assert page.has_content? concert_1.band
    refute page.has_content? concert_2.band
  end

  test "guest can filter by band" do
    venue = create(:venue, status: 1)
    concert_1 = create(:concert, venue: venue)
    concert_2 = create(:concert, venue: venue)

    visit root_path

    assert page.has_content? concert_1.band
    assert page.has_content? concert_2.band

    fill_in 'search[Band]', with: concert_1.band
    find("#search",:visible=>false).click

    assert_equal search_path, current_path

    assert page.has_content? concert_1.band
    refute page.has_content? concert_2.band
  end

  test "registered user can filter by band" do
    user = create(:user, role: 0)
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    venue = create(:venue, status: 1)
    concert_1 = create(:concert, venue: venue)
    concert_2 = create(:concert, venue: venue)

    visit root_path

    assert page.has_content? concert_1.band
    assert page.has_content? concert_2.band

    fill_in 'search[Band]', with: concert_1.band
    find("#search",:visible=>false).click

    assert_equal search_path, current_path

    assert page.has_content? concert_1.band
    refute page.has_content? concert_2.band
  end

  test "business_admin can filter by band" do
    user = create(:user, role: 1)
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    venue = create(:venue, status: 1)
    concert_1 = create(:concert, venue: venue)
    concert_2 = create(:concert, venue: venue)

    visit root_path

    assert page.has_content? concert_1.band
    assert page.has_content? concert_2.band

    fill_in 'search[Band]', with: concert_1.band
    find("#search",:visible=>false).click

    assert_equal search_path, current_path

    assert page.has_content? concert_1.band
    refute page.has_content? concert_2.band
  end

  test "platform_admin can filter by band" do
    user = create(:user, role: 2)
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    venue = create(:venue, status: 1)
    concert_1 = create(:concert, venue: venue)
    concert_2 = create(:concert, venue: venue)

    visit root_path

    assert page.has_content? concert_1.band
    assert page.has_content? concert_2.band

    fill_in 'search[Band]', with: concert_1.band
    find("#search",:visible=>false).click

    assert_equal search_path, current_path

    assert page.has_content? concert_1.band
    refute page.has_content? concert_2.band
  end

  test "guest can filter by band and city" do
    venue_1 = create(:venue, status: 1, city: 'alicante')
    venue_2 = create(:venue, status: 1, city: 'denver')

    concert_1 = create(:concert, venue: venue_1, band: "Slota and the Big Blues Band")
    concert_2 = create(:concert, venue: venue_1)
    concert_3 = create(:concert, venue: venue_2)

    visit root_path

    assert page.has_content? concert_1.band
    assert page.has_content? concert_2.band
    assert page.has_content? concert_3.band

    fill_in 'search[Band]', with: concert_1.band
    fill_in 'search[City]', with: concert_1.venue.city
    find("#search",:visible=>false).click

    assert_equal search_path, current_path

    assert page.has_content? concert_1.band
    refute page.has_content? concert_2.band
    refute page.has_content? concert_3.band
  end
end
