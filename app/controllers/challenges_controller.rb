class ChallengesController < ApplicationController

  before_action :is_authenticated?

  # helper functions
  # get user challenge role by user and challenge_id
  def get_user_challenge_role(user, challenge_id)
    role = user.user_challenges.find_by_challenge_id(challenge_id).role
  end
  helper_method :get_user_challenge_role

  def get_user_from_message(message_id)
    cur_message = Message.find_by_id(message_id)
    user = message.user
  end
  helper_method :get_user_from_message
  # end helper methods

  def index
    @challenges = Challenge.all
    @user = current_user
    @current_user = current_user
  end

  def show
    user_id = params[:user_id]
    c_id = params[:id]
    @user = User.find_by_id(params[:user_id])
    @current_user = current_user
    @is_challenge_owner = @user.id == @current_user.id
    @challenge = User.find_by_id(user_id).challenges.find_by_id(c_id)
    # dates
    @is_past = is_past
    @duration = get_duration(@challenge.start_date, @challenge.end_date)
    @messages = @challenge.messages.all
    # calendar
    # number of days / 7 = num of rows
    # backburner the calendar until messages are working
    respond_to do |f|
      f.json {render :json => {challenge: [@challenge]}}
      f.html
    end
  end

  def new

    @current_user = current_user
    @challenge= Challenge.new
    @user =User.find_by_id(params[:user_id])

  end

  def create
    new_challenge =params.require(:challenge).permit(:title,:charity_id,:start_date,:end_date,:status,:challenge_amount)
    phone_numbers = params[:phone_numbers].split(' ')

    @challenge = Challenge.create(new_challenge)
    puts @challenge.id

    @user = current_user
    @current_user = current_user
    @user.challenges << @challenge

    user_challenge = UserChallenge.where({challenge_id: @challenge.id})
    user_challenge[0].role = "challenger"

    binding.pry

    is_new = true
    phone_numbers.each do |phone|
      if User.find_by_phone_number(phone)
        is_new = false
      else
        is_new = true
      end
      send_text_message(phone, @challenge.id, is_new)
    end

    redirect_to "/users/#{@user.id}/challenges/#{@challenge.id}"

  end

  def edit
    @user = User.find_by_id(params[:user_id])

  end

  def update

  end

  def delete
  end


  private

  def is_past

    @challenge.end_date.to_datetime < DateTime.now
  end

  def get_duration(start_d, end_d)
    start_date = start_d.to_datetime
    end_date = end_d.to_datetime
    today = DateTime.now
    duration = Hash.new
    duration[:today] = today
    duration[:completed] = (today - start_date).to_i
    duration[:total] = (end_date - start_date).to_i,
    duration[:pct_complete] = (((today - start_date).to_f / (end_date - start_date).to_f) * 100).round
    return duration
  end

  def send_text_message(number_to_send_to, challenge_id, is_new)

    twilio_sid = ENV['ACCOUNT_SID']
    twilio_token = ENV['AUTH_TOKEN']

    puts "WE GETTING ANYTHING??"
    puts twilio_sid
    puts twilio_token

    twilio_phone_number = "6502760630"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    body = "You have been invited to join a challenge!  Go to http://thejarr.herokuapp.com/users/new?challenge_id=#{challenge_id}"
    if is_new
      body = "You have been invited to join a challenge!  Go to http://thejarr.herokuapp.com/users/new?challenge_id=#{challenge_id}"
    else
      body = "You have been invited to join a challenge!  Go to http://thejarr.herokuapp.com/login?challenge_id=#{challenge_id}"
    end

    @twilio_client.account.sms.messages.create(
      :from => "16502760630",
      :to => number_to_send_to,
      :body => body
      )
  end

end
