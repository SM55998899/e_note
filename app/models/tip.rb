class Tip < ApplicationRecord
	belongs_to :list

	validates :title, presence: true, length: { in: 1..55 }
  validates :memo, length: { maximum: 100 }
end
