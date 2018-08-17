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

	def giftmoji_has_no_owner?
		giftmoji.user_id == "" || giftmoji.user_id == nil || giftmoji.user_id == false
	end 

	def giftmoji_owner?
		current_user == @giftmoji.user 
	end 
end
