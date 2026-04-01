require "test_helper"

class UsersControllerTest < BaseTestController
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user)
    get new_user_url
    # cannot create new user
    assert_response :not_found
  end

  test "should create user" do
    sign_in_as(@user)
    # cannot create new user, only seed
    assert_difference("User.count", 0) do
      post users_url, params: { user: { name: "Charlie", email: "charlie@example.com", password: "password", password_confirmation: "password" } }
    end
    assert_response :not_found
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    sign_in_as(@user)
    patch user_url(@user), params: { user: { name: @user.name, email: @user.email, password: "newpassword", password_confirmation: "newpassword" } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    sign_in_as(@user)
    # cannot delete user
    assert_difference("User.count", 0) do
      delete user_url(@user)
    end
    assert_response :not_found
  end
end
