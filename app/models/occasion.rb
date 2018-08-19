class Occasion < ApplicationRecord
		has_many :giftmojis
		validates :name, presence: true 

	def self.most_popular_occasion
		
	end

end
