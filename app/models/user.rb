class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

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
