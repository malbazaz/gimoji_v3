class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create 
    #binding.pry
  	 if params[:user][:username]
    	@user = User.find_by(username: params[:user][:username])
	   end  
    #binding.pry
	   if @user
    	return redirect_to 'login' unless @user.authenticate(params[:user][:password])
    	session[:user_id] = @user.id
    	redirect_to "/users/#{@user.id}"
      end
  end 

  def destroy
    session.delete :user_id 
    redirect_to '/'
  end 



end 