class Occasion < ApplicationRecord
		has_many :giftmojis
		validates :name, presence: true 
		#delegate :url_helpers, to: 'Rails.application.routes'
		include Rails.application.routes.url_helpers

	def self.most_popular_occasion
		Occasion.joins(:giftmojis).group("giftmojis.id").order("count(giftmojis.id) ASC").limit(1).pluck(:name)[0]
	end


end
