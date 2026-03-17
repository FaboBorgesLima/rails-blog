class ApplicationController < ActionController::Base
  include Authentication
  include RateLimiter
  before_action :set_auth_user
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
