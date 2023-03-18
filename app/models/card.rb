class Card < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  default_scope -> { order(created_at: :desc) }
  has_many :likes,dependent: :destroy
  validates :user_id, presence: true
  validates :front, presence: true, length: { maximum: 20 }
  validates :back, presence: true, length: { maximum: 100 }

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
