class Giftmoji < ApplicationRecord
	belongs_to :user
	belongs_to :occasion
	has_many :giftmoji_emotions 
	has_many :emotions, through: :giftmoji_emotions

end
