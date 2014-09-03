class SessionsController < ApplicationController
  
  def new   
  end

  def create
  	@user=User.authenticate(params[:user][:email], params[:user][:password])

  	if @user
  		session[:user_id]= @user.id
<<<<<<< HEAD
  		redirect_to user_path(@user), notice: "logged in"
=======
  		redirect_to "/users/:id", notice: "logged in"
>>>>>>> 7fd8d4d6db9a48805859e83e1f026c7578844201
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
