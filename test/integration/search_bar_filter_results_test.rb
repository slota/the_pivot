require 'test_helper'

class SearchBarFilterResultsTest < ActionDispatch::IntegrationTest
  test "guest can filter by genre" do
    genre_1, genre_2 = create_list(:category, 2)
    venue = create(:venue, status: 1)
    concert_1 = create(:concert, category: genre_1)
    concert_2 = create(:concert, category: genre_2)
    venue.concerts << [concert_1, concert_2]

    visit root_path
    # save_and_open_page
    assert page.has_content? concert_1.band
    assert page.has_content? genre_1.description
    assert page.has_content? concert_2.band
    assert page.has_content? genre_2.description

    find('#organizationSelect').find(:xpath, 'option[2]').select_option
  end
end
