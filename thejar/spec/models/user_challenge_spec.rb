require 'rails_helper'

RSpec.describe UserChallenge, :type => :model do
  before :each do
    @challenge = Challenge.create(title: 'New', start_date: DateTime.now, end_date: DateTime.tomorrow, status: "done")
    @user = User.create(first_name: 'Joe', last_name: 'Doe', email: 'joe@doe.com', phone_number: '+16505555555', img_url: 'some_url')
  end

  it "should allow user to be added to a challenge" do
    @challenge.users << @user
    expect(@challenge.users.size).to eql(1)
    expect(@user.challenges.size).to eql(1)
  end

  it "should allow role to be added to user_challenge" do
    @challenge.users << @user
    user_challenge = @user.user_challenges.last
    user_challenge.update_attributes(role: 'supporter')
    expect(user_challenge.role).to eql('supporter')
  end
end
