class Giftmoji < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :occasion, optional: true
	has_many :giftmoji_emotions 
	has_many :emotions, through: :giftmoji_emotions
	validates :price, :presence => true
	validates :name, presence: true 

	def gift(recipient_name) 
		if self.user_id == session[:user_id]
			@user = User.find_by_fullname(recipient_name)
  			self.user = @user
  			self.save
  		end 
  	end 

  	def Giftmoji.name_of_most_expensive
  	@most_expensive	= Giftmoji.all.order(price: :desc).limit(1).pluck(:name)[0]
  	end



  # add class of gimoji with most emotions
  # add most gifts on what occasion 

end
