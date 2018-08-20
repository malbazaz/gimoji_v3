class Giftmoji < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :occasion, optional: true
	has_many :giftmoji_emotions 
	has_many :emotions, through: :giftmoji_emotions
	validates :price, :presence => true
	validates :name, presence: true 
	validates :name, uniqueness: true
	validates :price, numericality: {greater_than: 0}


	def gift(recipient_name) 
		if self.user_id == session[:user_id]
			@user = User.find_by_fullname(recipient_name)
  			self.user = @user
  			self.save
  		end 
  	end 

  	def self.name_of_most_expensive
  	@most_expensive	= Giftmoji.all.order(price: :desc).limit(1).pluck(:name)[0]
  	end

  	def self.name_of_cheapest 
  	@most_expensive	= Giftmoji.all.order(price: :asc).limit(1).pluck(:name)[0]
  	end 

 	def self.ids_without_owner 
 		Giftmoji.where(user_id: :nil).pluck(:id)
 	end 

 	def self.name_of_birthday_giftmojis
 		Giftmoji.joins(:occasion).where(occasions:{name: "Birthday"}).pluck(:name)
	end 

 	def self.happy_ones 
 		 Giftmoji.joins(:emotions).where(emotions:{name: "Happy"}).pluck(:name)
 	end

 	def self.sad_ones 
 		Giftmoji.includes(:emotions).where(emotions: {name: "Sad"}).pluck(:name)
	end 


  # add class of gimoji with most emotions
  # add most gifts on what occasion 

end
