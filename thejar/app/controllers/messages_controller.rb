class MessagesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @message = Message.new

  end

  def create
    new_message = params.require(:message).permit(:text, :is_private, :is_caught, :is_confirmed, :is_invitation)
    challenge_id = params[:challenge_id]
    # @user = current_user
    @user = User.find_by_id(1)
    @message = @user.messages.create(text: new_message[:text], is_private: new_message[:is_private], is_confirmed: new_message[:is_confirmed], is_caught: new_message[:is_caught], is_invitation: new_message[:is_invitation], challenge_id: challenge_id)

    respond_to do |f|
      f.json {render :json => {message: {message: @message, user: @user}}
      f.html
    end
  end

  def edit
  end

  def update
  end

  def delete
  end
end
