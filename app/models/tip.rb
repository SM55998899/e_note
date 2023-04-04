class Tip < ApplicationRecord
	belongs_to :list
	default_scope -> { order(created_at: :asc) }
	validates :title, presence: true, length: { in: 1..55 }
  validates :memo, length: { maximum: 100 }
end
