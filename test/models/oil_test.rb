require "test_helper"

class OilTest < ActiveSupport::TestCase
  test "an oil type category can be created with valid attributes" do
    oil = Oil.new(name: "Lard", slug: "lard")

    assert oil.valid?
    assert_equal "Lard", oil.name
    assert_equal "lard", oil.slug
  end

  test "an oil type category can not be created without a name" do
    oil = Oil.new

    assert oil.invalid?
  end

  test "an oil type category can not be created without a unique name" do
    Oil.create(name: "Lard")
    oil2 = Oil.new(name: "Lard")

    assert oil2.invalid?
  end

  test "a category name slug can be made" do
    oil = Oil.new(name: "Coconut Oil")

    assert_equal "coconut-oil", oil.set_slug
  end

  test 'a category can send its slug to params' do
    create_shop
    oil = Oil.create(name: "Coconut Oil")
    oil.set_slug
    assert_equal "coconut-oil", oil.to_param
  end
end
