class OccasionsController < ApplicationController
	def new 
        @occasion = Occasion.new 
        if session[:user_id]
            @user = User.find_by_id(session[:user_id])
            if @user.admin
                render "new"
            end 
        end 
    end

    def create 
        @occasion = Occasion.create(attr_params)
        redirect_to "/occasions/#{@occasion.id}"
    end 

    def index 
        if !!session[:user_id]
            @occasions = Occasion.all
        else 
            redirect_to '/'
        end
    end 

    def show 
        @occasion = Occasion.find_by_id(params[:id])
        @user = User.find_by_id(session[:user_id])
    end 

    def edit 
        @occasion = Occasion.find_by_id(params[:id])
    end 

    def update
        @occasion = Occasion.find_by_id(params[:id])
        @occasion.update(attr_params)
        @occasion.save 
        redirect_to "/occasions/#{@occasion.id}"
    end 
    private 

    def attr_params 
        params.require(:occasion).permit(:name)
    end 
end

