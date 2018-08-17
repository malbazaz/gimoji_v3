class Giftmoji < ApplicationRecord
	belongs_to :user
	belongs_to :occasion
	has_many :giftmoji_emotions 
	has_many :emotions, through: :giftmoji_emotions


	def gift(recipient_name) 
		if self.user_id == session[:user_id]
			@user = User.find_by_fullname(recipient_name)
  			self.user = @user
  			self.save
  		end 
  	end 


  # add class method of [most expensive giftmoji]
  # add class of gimoji with most emotions
  # add most gifts on what occasion 

end
