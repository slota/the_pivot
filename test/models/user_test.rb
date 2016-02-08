require "test_helper"

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:username)
  should validate_uniqueness_of(:username)
  should validate_presence_of(:password)

  test 'user default role is not admin' do
    user = User.create(username: "John", password: "Password")

    assert_equal "registered_user", user.role
  end
end
