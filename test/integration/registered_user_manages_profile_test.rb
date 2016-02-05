require 'test_helper'

class RegisteredUserManagesProfileTest < ActionDispatch::IntegrationTest
  test 'registered user can log in' do
    user = create(:user)
    user.update(role: 1)

    visit root_path
    within ".right" do
      click_link "Login"
    end

    fill_in "Username", with: "John"
    fill_in "Password", with: "pass"

    click_button "Login"
    save_and_open_page
  end
end
