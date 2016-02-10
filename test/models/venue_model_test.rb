require 'test_helper'

class VenueModelTest < ActionDispatch::IntegrationTest
  def setup
    @venue = Venue.new(name: "too kewl")
  end

  test 'url' do
    assert_equal @venue.generate_url, "too-kewl"
  end
end
