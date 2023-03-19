class List < ApplicationRecord
	belongs_to :user
	has_many :tips, dependent: :destroy
	validates :title, length: { in: 1..255 }
end
