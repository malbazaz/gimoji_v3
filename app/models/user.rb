class User < ApplicationRecord
		has_secure_password
         has_many :giftmojis
         has_many :giftmoji_emotions, through: :giftmojis 
         has_many :emotions, through: :giftmoji_emotions
         has_many :occasions, through: :giftmojis
         validates :fullname, presence: true 
         validates :username, uniqueness: true
         validates :uid, presence: true, unless: :password
  		 validates :password, presence: true, unless: :uid

    def buy(giftmoji)
		if self.giftcoins > giftmoji.price
			self.giftcoins -= giftmoji.price 
			giftmoji.user_id = self.id 
			giftmoji.save 
			self.save 
			"You have successfully bought the #{giftmoji.name} Giftmoji"
		else 
			"You don't have any enough giftcoins to purchase this Giftmoji"
		end 
	end 


	def self.most_giftmojis
		User.joins(:giftmojis).group("giftmojis.id").order("count(giftmojis.id) DESC").limit(1).pluck(:fullname)[0]
	end 

end
