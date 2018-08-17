class Giftmoji < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :occasion, optional: true
	has_many :giftmoji_emotions 
	has_many :emotions, through: :giftmoji_emotions
	validates :user_id, :presence => false
	validates :occasion_id, :presence => false

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
