class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.all
  end

  def show
    user_id = params[:user_id]
    c_id = params[:id]
    @challenge = User.find_by_id(user_id).challenges.find_by_id(c_id)
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
end
