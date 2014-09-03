class MessagesController < ApplicationController
  def index
    @user = User.find_by_id(params[:user_id])
    @messages = @user.challenges.find_by_id(params[:challenge_id]).messages.all.order('created_at DESC')
    @user_messages = []
    @messages.each do |message|
      user = User.find_by_id(message.user_id)
      @user_messages.push({user: user, message: message})
    end

    respond_to do |f|
      f.json {render json: {message: @user_messages}}
    end
  end

  def show
  end

  def new
    @message = Message.new

  end

  def create
    new_message = params.require(:message).permit(:text, :is_private, :is_caught, :is_confirmed, :is_invitation, :img_url, :challenge_id)
    @user = current_user
    @message = @user.messages.create(new_message)
    @message_p = Message.find_by_sql('select * from messages join "users" on messages.user_id = users.id;').last

    respond_to do |f|
      f.json {render :json => {message: [{message: @message_p}]}}
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
