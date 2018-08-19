class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create 
    #binding.pry
    if params[:user][:username]
      @user = User.find_by(username: params[:user][:username])
      if @user
        return redirect_to 'login' unless @user.authenticate(params[:user][:password])
      end 
    else
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.username = auth['info']['username']
        u.email = auth['info']['email']
      end 
    end 
      session[:user_id] = @user.id 
      redirect_to "/users/#{@user.id}"
  end 

  def destroy
    session.delete :user_id 
    redirect_to '/'
  end 

private 
  def auth 
    request.env['omniauth.auth']
  end



end 