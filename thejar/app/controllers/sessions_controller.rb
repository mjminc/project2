class SessionsController < ApplicationController
  
  def new   
  end

  def create
  	@user=User.authenticate(params[:user][:email], params[:user][:password])

  	if @user
  		session[:user_id]= @user.id
  		redirect_to login_url, notice: "logged in"
  	else
  		flash.now[:error] = "not logged in"
  		render :new
  	end
  end


  def destroy
  	session[:user_id]=nil
    redirect_to login_url, notice: "Session Destruction - logged out"
  end
  
end
