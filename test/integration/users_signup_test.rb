require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      user_params = { username:  "",
                               email: "user@invalid",
                               phone: "333333333333",
                               password:              "foo",
                               password_confirmation: "bar" }
      post users_path, params: { user: user_params }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      user_params = { username: "User",
                      email: "example@mail.eu",
                      phone: "+333333333333",
                      password: "password",
                      password_confirmation: "password"}
      post users_path, params: { user: user_params }
    end
    assert is_signed_in?
  end
end
