class User < ApplicationRecord
		has_secure_password
         has_many :giftmojis
         has_many :giftmoji_emotions, through: :giftmojis 
         has_many :emotions, through: :giftmoji_emotions
         has_many :occasions, through: :giftmojis
         validates :password, length: 4..20
         validates :fullname, presence: true 

    def buy(gimoji)
		if self.gift_coins >= giftmoji.price
			self.gift_coins -= giftmoji.price 
			giftmoji.user_id = self.id 
			giftmoji.save 
			self.save 
		else 
			"You don't have any enough giftcoins to purchase this giftmoji"
		end 
	end 
end
