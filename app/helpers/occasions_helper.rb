module OccasionsHelper
	include Rails.application.routes.url_helpers

	class << self 

	def most_popular_occasion
		Occasion.joins(:giftmojis).group("giftmojis.id").order("count(giftmojis.id) ASC").limit(1).pluck(:name)
		#occasion_path(self)
	end

end 
end
