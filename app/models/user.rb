class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :github_url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_blank: true
  validates :linkedin_url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_blank: true
  validates :linkedin_username, length: { maximum: 100 }, allow_blank: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :posts, dependent: :destroy

  def can_edit?(user)
    user.id == id
  end

  def can_destroy?(user)
    user.id == id
  end

  def self.from_session(session)
    find_by(id: session[:user_id])
  end

  def get_github_username
    return nil if github_url.blank?
    URI.parse(github_url).path.split("/").last
  end

  def get_linkedin_username
    return linkedin_username if linkedin_username.present? && !linkedin_username.strip.empty?
    return nil if linkedin_url.blank?
    URI.parse(linkedin_url).path.split("/").last
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    user if user&.authenticate(password)
  end

  def logout!(session)
    session.delete(:user_id)
  end

  def login!(session)
    session[:user_id] = id
  end
end
