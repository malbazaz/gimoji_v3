require 'pry'
class GiftmojisController < ApplicationController
	
    def new 
        if params[:occasion_id]
            @giftmoji = Giftmoji.new(occasion_id: params[:occasion_id])
        else 
            @giftmoji = Giftmoji.new 
        end 
        #binding.pry
        if session[:user_id]
            @user = User.find_by_id(session[:user_id])
           
           # if @user.admin
           #     render "new"
           # elsif @giftmoji.user_id == @user 
           #     render "new" 
           # end 
        end 
    end

    def create 
        #binding.pry
        @giftmoji = Giftmoji.create(giftmoji_params)
        #binding.pry
        if params[:giftmoji][:emotion_ids]
        emotion_ids = params[:giftmoji][:emotion_ids]
        emotion_ids.each do |em|
           # binding.pry
            if  em !=""
                emotion = Emotion.find_by_id(em)
                @giftmoji.emotions << emotion
            end 
        end 
    end 
        emo = Emotion.find_or_create_by(name: params[:giftmoji][:emotions][:name])
        @giftmoji.emotions << emo
        @giftmoji.save
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
    #binding.pry
    if params[:id]
        @giftmoji = Giftmoji.find_by_id(params[:id])
        @giftmoji.update(attr_params)
        @giftmoji.save 
        redirect_to "/giftmojis/#{@giftmoji.id}"
    end
    end 
    private 

    def giftmoji_params 
        params.require(:giftmoji).permit(:name, :tag, :price, :message, :occasion_id, :user_id)
    end 
end
