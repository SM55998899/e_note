class Card < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :front, presence: true, length: { maximum: 20 }
  validates :back, presence: true, length: { maximum: 100 }
end
