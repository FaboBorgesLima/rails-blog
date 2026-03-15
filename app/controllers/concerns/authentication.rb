module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_auth_user
    before_action :set_guest
    helper_method :auth_user
  end

  def auth_user
    @auth_user
  end

  def set_auth_user
    @auth_user = User.from_session(session)
  end

  def set_guest
    @guest = !@auth_user.present?
  end

  def authenticated?
    @auth_user.present?
  end

  def authenticate
    unless authenticated?
      redirect_to login_path, alert: "You must be logged in to perform this action."
    end
  end
end
