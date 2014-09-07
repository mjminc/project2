class UsersController < ApplicationController

  skip_before_action :is_authenticated?, only: [:new, :create]

  def index
    @user = User.all.order(created_at: :desc)
    @current_user = current_user
  end


  def show
    @user = User.find_by_id(params[:id])
    @current_user = current_user
  end


  def new
    @user = User.new
    if session[:user_id] != nil
        redirect_to root_path
    end

    if params[:challenge_id] != nil
      @challenge_id = params[:challenge_id]
    end
  end


  def create

    new_user = params[:user].permit(:email, :avatar, :password, :password_confirmation, :first_name, :last_name, :phone_number)

    challenge_id = params[:challenge]
    check_if_new_user = User.new(new_user)

      if check_if_new_user.save!

        if challenge_id != nil && challenge_id != ''
          challenge = Challenge.find_by_id(challenge_id)
          user = User.find_by_email(new_user[:email])
          # user.challenges << challenge
          # user_challenge = UserChallenge.where(challenge_id: challenge.id, user_id: user.id)

          # user_challenge[0].role = "supporter"
          # user_challenge[0].is_accepted = true
        end
        binding.pry
        redirect_to '/login?challenge_id=#{challenge_id}', :notice => "User Created!"
      else
        flash.now[:notice]="Can't create user"
        @user = User.new
        render 'users/new'
      end
  end



  def edit
    find_user_id

    render :edit
  end


  def update
    find_user_id
    @current_user = current_user
    updated_params = params.require(:user).permit(:email, :first_name, :last_name, :avatar)
    @user.update_attributes(updated_params)
    redirect_to user_path(@user)
  end


  def delete
    find_user_id

    @user.destroy
    redirect_to "/"
  end


  private

    def find_user_id
      user_id = params[:id]
      @user = User.find(user_id)
    end

end
