class UsersController < ApplicationController

  skip_before_action :is_authenticated?, only: [:new, :create]

  def index
    @user = User.all.order(created_at: :desc)
  end


  def show
     @user = User.find_by_id(params[:id])
    @current_user = session[:user_id]
  end


  def new
    @user = User.new
    if session[:user_id] != nil
        redirect_to root_path
    end

  end


  def create


    new_user = params[:user].permit(:email,:avatar, :password, :password_confirmation, :first_name, :last_name, :phone_number)
    check_if_new_user = User.new(new_user)
      if check_if_new_user.save
        redirect_to users_path, :notice => "User Created!"
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

    updated_params = params.require(:user).permit(:email, :first_name, :last_name)
    user.update_attributes(updated_params)
    redirect_to user
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
