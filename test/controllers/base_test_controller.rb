
class BaseTestController < ActionDispatch::IntegrationTest
  def sign_in_as(user)
    post login_url, params: { email: user.email, password: "password" }
  end
end
