class EmotionsController < ApplicationController
	def new 
        @emotion = Emotion.new 
        if session[:user_id]
            @user = User.find_by_id(session[:user_id])
            if @user.admin
                render "new"
            end 
        end 
    end

    def create 
        @emotion = Emotion.create(attr_params)
        redirect_to "/emotions/#{@emotion.id}"
    end 

    def index 
        
        if !!session[:user_id]
            @emotions = emotion.all
        else 
            redirect_to '/'
        end
    end 

    def show 
        @emotion = Emotion.find_by_id(params[:id])
        @user = User.find_by_id(session[:user_id])
    end 

    def edit 
        @emotion = Emotion.find_by_id(params[:id])
    end 

    def update
        @emotion = Emotion.find_by_id(params[:id])
        @emotion.update(attr_params)
        @emotion.save 
        redirect_to "/emotions/#{@emotion.id}"
    end 
    private 

    def attr_params 
        params.require(:emotion).permit(:name)
    end 
end

