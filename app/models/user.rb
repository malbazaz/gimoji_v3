class User < ApplicationRecord
         has_many :giftmojis
         has_many :giftmoji_emotions, through: :giftmojis 
         has_many :emotions, through: :giftmoji_emotions
end
