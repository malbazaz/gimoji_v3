class Occasion < ApplicationRecord
		has_many :giftmojis
		validates :name, presence: true 

	def self.most_popular_occasion
		Occasion.joins(:giftmojis).group("giftmojis.id").order("count(giftmojis.id) ASC").limit(1)
	end

end
