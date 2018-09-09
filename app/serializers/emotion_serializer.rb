class EmotionSerializer < ActiveModel::Serializer
  attributes :id, :name 
  belongs_to :giftmoji
end
