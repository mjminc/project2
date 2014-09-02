class UsersController < ApplicationController
  def index
    @user = User.all.order(created_at: :desc)
  end


  def show
    # @user = User.new
    @current_user = session[:user_id]
  end


  def new
    @user = User.new
    @current_user = session[:user_id]
  end


  def create
    new_user = params[:user].permit(:email, :email_confirmation, :password, :password_confirmation, :first_name, :last_name, :phone_number)
    check_if_new_user = User.new(new_user)
      if check_if_new_user.save
        redirect_to users_path
      else
        flash.now[:notice]="Can't create user"
        @user = User.new
        render 'users/new'
      end
  end


  def edit
    user_id = params[:id]
    @user = User.find(id)
    render :edit
  end


  def update
    user_id = params[:id]
    user = User.find(user_id)
    updated_params = params.require(:user).permit(:email, :first_name, :last_name)
    user.update_attributes(updated_params)
    redirect_to user
  end


  def delete
    id = params[:id]
    user = User.find(id)
    user.destroy
    redirect_to "/"
  end


end
