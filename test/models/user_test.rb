require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'user default role is not admin' do
    user = User.create(username: "John", password: "Password")

    assert_equal "registered_user", user.role
  end
end
