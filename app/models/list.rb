class List < ApplicationRecord
	belongs_to :user
	default_scope -> { order(created_at: :asc) }
	has_many :tips, dependent: :destroy
	validates :title, presence: true, length: { in: 1..55 }
end
