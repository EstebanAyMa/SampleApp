require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end

  # test "valid signup information" do
  #   Capybara.app_host = "http://127.0.0.1:3000"
  #
  #   assert_difference 'User.count', 1 do
  #     post users_path, params: { user: { first_name:  "Example",
  #                                        last_name: "User",
  #                                        email: "user@example.com",
  #                                        activated: true,
  #                                        password:              "test1234",
  #                                        password_confirmation: "test1234" } }
  #   end
  #   follow_redirect!
  #   assert_template 'users/show'
  # end
end
