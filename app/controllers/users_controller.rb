class UsersController < ApplicationController

	def new
        @user = User.new
    end 
    
    def create 
        #binding.pry
        @user= User.create(user_params)
        session[:user_id]= @user.id
        redirect_to '/users/:id'
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

    def update
        @user = User.find_by_id(session[:user_id])
        if params[:giftmoji][:id]
            @giftmoji = Giftmoji.find_by_id(params[:giftmoji][:id])
            @giftmoji.user = @user 
            @giftmoji.save
            #binding.pry 
            @user.giftcoins -= @giftmoji.price 
            @user.save
            # FLASH MESSAGE  
        end  
        #binding.pry
        redirect_to "/users/#{@user.id}"
    end 

    private 

    def user_params 
        params.require(:user).permit(:fullname, :username, :password, :giftcoins, :admin, :email, :password_confirmation)
    end 

end
