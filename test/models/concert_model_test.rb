require 'test_helper'

class ConcertModelTest < ActionDispatch::IntegrationTest
  def setup
    @concert = Concert.new(date: "2016-01-02",
                band: "too kewl")
  end

  test 'url' do
    assert_equal @concert.generate_url, "2016-01-02-too-kewl"
  end
end
