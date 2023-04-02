class List < ApplicationRecord
	belongs_to :user
	has_many :tips, dependent: :destroy
	validates :title, presence: true, length: { in: 1..55 }
end
