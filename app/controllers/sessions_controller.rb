class SessionsController < ApplicationController

  def new
    puts session[:user_id]
    @challenge_id = params[:challenge_id]
  end

  def create
  	@user=User.authenticate(params[:user][:email], params[:user][:password])
    challenge_id = params[:challenge]

  	if @user
  		session[:user_id]= @user.id
      challenge = Challenge.find_by_id(challenge_id)

      if challenge != nil
        user = User.find_by_id(@user.id)
        user.challenges << challenge
        user_challenge = UserChallenge.where(challenge_id: challenge_id, user_id: user.id)

        user_challenge[0].role = "supporter"
        user_challenge[0].is_accepted = true
      end

  		redirect_to user_path(@user), notice: "logged in"
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
