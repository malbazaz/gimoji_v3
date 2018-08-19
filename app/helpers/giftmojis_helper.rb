require 'pry'
module GiftmojisHelper

		def current_user 
			user = User.find_by_id(session[:user_id])
		end 

	def giftmoji_gifted? 
		if @giftmoji.message == "" || @giftmoji.message == nil 
			false 
		elsif @giftmoji.occasion == "" || @giftmoji.occasion == nil 
			false 
		else 
			true 
		end  
	end

	def giftmoji_owner?
		current_user == @giftmoji.user 
	end 

	def no_owner?
		Giftmoji.any? { |u| u.user_id.nil? }
	end 

end
