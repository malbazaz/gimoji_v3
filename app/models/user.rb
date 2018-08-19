class User < ApplicationRecord
		has_secure_password
         has_many :giftmojis
         has_many :giftmoji_emotions, through: :giftmojis 
         has_many :emotions, through: :giftmoji_emotions
         has_many :occasions, through: :giftmojis
         validates :fullname, presence: true 

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
end
