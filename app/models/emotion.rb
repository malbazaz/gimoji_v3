class Emotion < ApplicationRecord
	has_many :giftmoji_emotions
	has_many :giftmojis, through: :giftmoji_emotions
	has_many :users, through: :giftmojis
	validates :name, presence: true 
end
