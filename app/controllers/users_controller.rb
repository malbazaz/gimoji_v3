class UsersController < ApplicationController

	def new
        @user = User.new
    end 
    
    def create 
        binding.pry
        @user= User.create(user_params)
        session[:user_id]= @user.id
    end 

	def index
        @users = User.all
    end 


    def show 
        if !!session[:user_id]
             @user = User.find_by_id(params[:id])
        else 
            redirect_to '/'
        end
    end 


    private 

    def user_params 
        params.require(:user).permit(:fullname, :username, :password, :giftcoins, :admin, :email)
    end 

end
