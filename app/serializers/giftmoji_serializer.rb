class GiftmojiSerializer < ActiveModel::Serializer
  attributes :id, :name, :tag, :price
  belongs_to :user
  has_many :emotions
end
