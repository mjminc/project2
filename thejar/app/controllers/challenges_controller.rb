class ChallengesController < ApplicationController
  before_action :is_authenticated?
  # helper functions
  # get user challenge role by user and challenge_id
  def get_user_challenge_role(user, challenge_id)
    role = user.user_challenges.find_by_challenge_id(challenge_id).role
  end
  helper_method :get_user_challenge_role

  def get_user_from_message(message)
    user = message.user
  end
  helper_method :get_user_from_message
  # end helper methods

  def index
    @challenges = Challenge.all
  end

  def show
    user_id = params[:user_id]
    c_id = params[:id]
    @challenge = User.find_by_id(user_id).challenges.find_by_id(c_id)
    # dates
    @is_past = is_past
    @duration = get_duration(@challenge.start_date, @challenge.end_date)
    @messages = @challenge.messages.all
    # calendar
    # number of days / 7 = num of rows
    # backburner the calendar until messages are working
  end

  def new
  end

  def create
  end

  def edit
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
end
