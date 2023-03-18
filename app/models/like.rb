class Like < ApplicationRecord
  belongs_to :card
  belongs_to :user
  validates_uniqueness_of :card_id, scope: :user_id
end
