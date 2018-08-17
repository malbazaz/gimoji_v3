class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create 
  	if params[:username]
    	@user = User.find_by(username: params[:username])
	else
		@user = User.find_by(email: params[:email])
	end  
	if @user
    	return redirect_to 'login' unless @user.authenticate(params[:password])
    	session[:user_id] = @user.id 
    	redirect_to "/users/#{@user.id}"
    end
    
  end 

  def destroy
    session.delete :user_id 
    redirect_to '/'
  end 



end 