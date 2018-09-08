class UserSerializer < ActiveModel::Serializer
  attributes :id, :fullname, :username, :admin, :email 
  has_many :giftmojis
end
