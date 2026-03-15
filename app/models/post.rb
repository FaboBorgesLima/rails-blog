class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 255 }
  validates :content, presence: true, length: { minimum: 20 }
  validates :user_id, presence: true
  validate :user_id_unchanged, on: :update

  def self.create_with_user(params, user)
    if !can_create?(user)
      raise "User does not have permission to create a post"
    end

    post = new(params)
    post.user = user
    post
  end

  def can_edit?(user)
    user.id == user_id
  end

  def can_destroy?(user)
    user.id == user_id
  end

  def self.can_create?(user)
    user.present?
  end

  def user_id_unchanged
    if user_id_changed? && persisted?
      errors.add(:user_id, "cannot be changed once set")
    end
  end
end
