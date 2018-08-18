require 'pry'
class GiftmojisController < ApplicationController
	
    def new 
        if params[:occasion_id]
            @giftmoji = Giftmoji.new(occasion_id: params[:occasion_id])
        else 
            @giftmoji = Giftmoji.new 
        end 

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
        @giftmoji = Giftmoji.create(giftmoji_params)
        update_gimoji_with_emotions_ids
        update_gimoji_with_emotion_name
        @giftmoji.save
        redirect_to "/giftmojis/#{@giftmoji.id}"
 
    end 

    def index 
        if !!session[:user_id]
            if params[:user_id]
                @giftmojis = User.find_by_id(params[:user_id]).giftmojis 
            else 
                @user = User.find_by_id(params[:id])
                if params[:occasion_id]
                    @giftmojis = Occasion.find(params[:occasion_id]).giftmojis
                else 
                    @giftmojis = Giftmoji.all
                end
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
    if params[:id]
        @giftmoji = Giftmoji.find_by_id(params[:id])
        @giftmoji.update(giftmoji_params)
        update_gimoji_with_emotions_ids
        update_gimoji_with_emotion_name
        @giftmoji.save
        if params[:commit]["Gift Gimoji"]
        # FLASH MESSAGE - SUCCESSFUL GIFT
        else
        # FLASH MESSAGE - SUCCESSFUL UPDATE
        end 
        redirect_to "/giftmojis/#{@giftmoji.id}"
    end

    end 
    private 

    def giftmoji_params 
        params.require(:giftmoji).permit(:name, :tag, :price, :message, :occasion_id, :user_id)
    end 

    def update_gimoji_with_emotions_ids
        if params[:giftmoji][:emotion_ids]
            emotion_ids = params[:giftmoji][:emotion_ids]
            emotion_ids.each do |em|
                if  em !=""
                    emotion = Emotion.find_by_id(em)
                    if !@giftmoji.emotions.include?(emotion)
                        @giftmoji.emotions << emotion
                    end
                end 
            end 
        end 
        @giftmoji.save
    end 
    def update_gimoji_with_emotion_name
        if params[:giftmoji][:emotions][:name] != ""
            emo = Emotion.find_or_create_by(name: params[:giftmoji][:emotions][:name])
            if !@giftmoji.emotions.include?(emotion)
                @giftmoji.emotions << emo
            end
            @giftmoji.save
        end 
    end 


end
