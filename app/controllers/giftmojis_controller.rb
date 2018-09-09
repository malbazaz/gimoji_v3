require 'pry'
class GiftmojisController < ApplicationController
	
    def new 
        if params[:occasion_id]
            @giftmoji = Giftmoji.new(occasion_id: params[:occasion_id])
        elsif params[:user_id]
             @giftmoji = Giftmoji.new(user_id: params[:user_id])
        else  
            @giftmoji = Giftmoji.new
        end 

        if session[:user_id]
            @user = User.find_by_id(session[:user_id])
        if !@user.admin
                redirect_to "/giftmojis"
        end     
           # if @user.admin
           #     render "new"
           # elsif @giftmoji.user_id == @user 
           #     render "new" 
           # end 
        end 

    end

    def create 
         # binding.pry
        @giftmoji = Giftmoji.create(giftmoji_params)
        update_giftmoji_with_emotions_ids
        update_giftmoji_with_emotion_name
        @giftmoji.save
        #         respond_to do |format|
        #     format.html
        #     format.json {render json: @giftmoji}
        # end 
        render json: @giftmoji, status: 201
        flash[:message] = "Congrats!!! You have successfully created a Giftmoji called #{@giftmoji.name}."
        # redirect_to "/giftmojis/#{@giftmoji.id}"
    end 

    def index 
        if !!session[:user_id]
            if params[:user_id]
                @giftmojis = User.find_by_id(params[:user_id]).giftmojis
                respond_to do |format|
                  format.html
                  format.json {render json: @giftmojis}
                end 
            else 
                @user = User.find_by_id(params[:id])
                if params[:occasion_id]
                    @giftmojis = Occasion.find(params[:occasion_id]).giftmojis
                else 
                    @giftmojis = Giftmoji.all
                    respond_to do |format|
                        format.html
                        format.json {render json: @giftmojis}
                    end 
                end
            end 
        else 
            flash[:message] = "Please login."
            redirect_to '/'
        end
    end 

    def show 
        @giftmoji = Giftmoji.find_by_id(params[:id])
        @user = User.find_by_id(session[:user_id])
        respond_to do |format|
                  format.html
                  format.json {render json: @giftmoji}
        end 
    end 

    def edit
        if session[:user_id]
            @user = User.find_by_id(session[:user_id])
            if !@user.admin
                redirect_to "/giftmojis"
            end
        @giftmoji = Giftmoji.find_by_id(params[:id])
        end
    end 

    def update
        if params[:id]
            #binding.pry 
            @giftmoji = Giftmoji.find_by_id(params[:id])
            @giftmoji.update(giftmoji_params)
            @giftmoji.gifted_by = User.find_by_id(session[:user_id]).fullname
            @giftmoji.save
            if params[:commit] == "Gift Giftmoji"
                flash[:message] = "You're gift was successful"
            else
                update_giftmoji_with_emotions_ids
                update_giftmoji_with_emotion_name
                @giftmoji.save
                flash[:message] = "You have succesfully updated the Giftmoji"
            end 
            redirect_to "/giftmojis/#{@giftmoji.id}"
        end
    end 

    private 

    def giftmoji_params 
        params.require(:giftmoji).permit(:name, :tag, :price, :message, :occasion_id, :user_id)
        
    end 

    def emotion_ids_params
        params.require(:giftmoji).permit(emotion_ids:[])
    end 

    def emotion_name_params
        params.require(:giftmoji).permit(emotions:[:name])
    end 
    def update_giftmoji_with_emotions_ids
        emotion_ids_params
        #binding.pry
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
    def update_giftmoji_with_emotion_name
        emotion_name_params
        #binding.pry
        if params[:giftmoji][:emotions][:name] != ""
            emo = Emotion.find_or_create_by(name: params[:giftmoji][:emotions][:name])
                @giftmoji.emotions << emo
            @giftmoji.save
        end 
    end 


end
