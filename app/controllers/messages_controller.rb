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
    @user = current_user
  end

  def new
    @message = Message.new

  end

  def create
    new_message = params.require(:message).permit(:text, :is_private, :is_caught, :is_confirmed, :is_invitation, :challenge_id)
    message_pic = params.permit(:msg_pic)
    @user = current_user
    @message = @user.messages.create(new_message)
    @message_u = Message.find_by_sql('select * from messages join "users" on messages.user_id = users.id;').last

    respond_to do |f|
      f.json {render :json => {message: [{message: @message_u}]}}
      f.html
    end
  end

  def edit
  end

  def update
    # coming from is_confirmed button click
    message_update = params.require(:message).permit(:text, :is_private, :is_caught, :is_confirmed, :is_invitation, :challenge_id)
    @message = Message.find_by_id(params[:id])
    @message.update_attributes(is_confirmed: message_update[:is_confirmed])

    # binding.pry
    challenge = Challenge.find_by_id(params[:challenge_id])
    c_amount = challenge.challenge_amount
    s_amount = challenge.supporter_amount
    days_left = get_days_left(challenge.start_date, challenge.end_date)
    increment = get_balance_increment(c_amount, s_amount, days_left)
    #
    challenge.update_attributes(challenge_amount: challenge.challenge_amount - increment)
    # binding.pry
    if challenge.supporter_amount
      challenge.update_attributes(supporter_amount: challenge.supporter_amount + increment)
    else
      challenge.update_attributes(supporter_amount: increment)
    end

    respond_to do |f|
      f.json {render :json => {message: [{message: @message}]}}
      f.html
    end
  end

  def delete
  end

  private
  def message_params
    params.require(:message).permit(:msgpic, :name)
  end

  def get_balance_increment(c_amount, s_amount, days_left)
    if s_amount != nil
      return increment = (c_amount + s_amount) / (days_left / 2)
    else
      return increment = c_amount / (days_left / 2)
    end
  end

  def status_check
  end
end












