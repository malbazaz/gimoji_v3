require 'pry'
class GiftmojisController < ApplicationController
	
    def new 
        if params[:occasion_id]
            @giftmoji = Giftmoji.new(occasion_id: params[:occasion_id])
        else 
            @giftmoji = Giftmoji.new 
        end 
        binding.pry
        if session[:user_id]
            @user = User.find_by_id(session[:user_id])
           
            #if @user.admin
            #    render "new"
            #elsif @giftmoji.user_id == @user 
            #    render "new" 
            #end 
        end 
    end

    def create 
        @giftmoji = Giftmoji.create(giftmoji_params)
        redirect_to "/giftmojis/#{@giftmoji.id}"
    end 

    def index 
        
        if !!session[:user_id]
            @user = User.find_by_id(params[:id])
            if params[:occasion_id]
                @giftmojis = Occasion.find(params[:occasion_id]).giftmojis
            else 
                @giftmojis = Giftmoji.all
            end
        else 
            redirect_to '/'
        end
    end 

    def show 
        @giftmoji = Giftmoji.find_by_id(params[:id])
        @user = User.find_by_id(session[:user_id])
    end 

    def edit 
        @giftmoji = Giftmoji.find_by_id(params[:id])
    end 

    def update
    # need to update giftmoji by admin & update when gifted 
    binding.pry
        @giftmoji = Giftmoji.find_by_id(params[:id])
        @giftmoji.update(attr_params)
        @giftmoji.save 
        redirect_to "/giftmojis/#{@giftmoji.id}"
    end 
    private 

    def giftmoji_params 
        params.require(:giftmoji).permit(:name, :tag, :message, :emotions, :occasion_id, :user_id)
    end 
end
