class Occasion < ApplicationRecord
		has_many :giftmojis
		validates :name, presence: true 
end
