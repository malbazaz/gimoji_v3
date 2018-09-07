class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create 
    #binding.pry 
    if !params[:user].nil?
      @user = User.find_by(username: params[:user][:username])
      if @user
        return redirect_to 'login' unless @user.authenticate(params[:user][:password])
      end 
    else
      #binding.pry
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.fullname = auth['info']['name']
        u.username = auth['info']['name'].gsub(" ", "-").downcase
        u.email = auth['info']['email']
        #u.password = auth['info']['name']
      end 
      @user.save 
      if @user.id.nil? && auth['uid']
          @user.id = @user.uid 
          @user.save 
      end 
      @user.save 
      
    end 
    if @user
      session[:user_id] = @user.id
      #binding.pry
      flash[:message] = "You have successfully logged in" 
      redirect_to "/users/#{@user.id}"
   else 
    flash[:message] = "Please enter the right data to login. Otherwise, sign up."
    @user = User.new
    render 'new'
   end 
  end 

  def destroy
    session.delete :user_id 
    flash[:message] = "You have successfully logged out."
    redirect_to '/'
  end 

private 
  def auth 
    request.env['omniauth.auth']
  end



end 