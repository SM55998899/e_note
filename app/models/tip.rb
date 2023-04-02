class Tip < ApplicationRecord
	belongs_to :list

	validates :title, presence: true, length: { in: 1..255 }
  validates :memo, length: { maximum: 1000 }
end
