require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "should create user" do
    visit users_url
    click_on "+ New user"

    fill_in "Name", with: "New User"
    fill_in "Email", with: "newuser@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "should update User" do
    visit user_url(@user)
    click_on "Edit profile", match: :first

    fill_in "Name", with: @user.name
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "should destroy User" do
    visit user_url(@user)
    accept_confirm { click_on "Delete account", match: :first }

    assert_text "User was successfully destroyed"
  end
end
