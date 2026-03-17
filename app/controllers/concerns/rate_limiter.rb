module RateLimiter
  extend ActiveSupport::Concern

  included do
    before_action :check_rate_limit_by_ip
  end

  private
  def check_rate_limit_by_ip
    ip = request.remote_ip
    key = "rate_limit:#{ip}"
    count = Rails.cache.read(key) || 0
    if count >= 60
      render plain: "Rate limit exceeded. Try again later.", status: :too_many_requests
    else
      Rails.cache.write(key, count + 1, expires_in: 1.minutes)
    end
  end
end
