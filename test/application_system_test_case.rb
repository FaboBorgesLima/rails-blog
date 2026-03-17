require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  def sign_in(user, password: "password")
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_on "Log In"
  end

  if ENV["CAPYBARA_SERVER_PORT"]
    served_by host: "rails-app", port: ENV["CAPYBARA_SERVER_PORT"]

    driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ], options: {
      browser: :remote,
      url: "http://#{ENV["SELENIUM_HOST"]}:4444"
    }
  else
    driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
  end
end
