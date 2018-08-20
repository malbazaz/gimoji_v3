module UsersHelper

	def user_admin?
        #binding.pry
        if session[:user_id]
            @current_user = User.find_by_id(session[:user_id])
            @current_user.admin
        end 
    end 

    def logged_in?
    	session[:user_id]
    end 

    def current_user?
        session[:user_id] == params[:id]
    end

    def user_name
    	User.find_by_id(session[:user_id]).fullname
    end 
end
