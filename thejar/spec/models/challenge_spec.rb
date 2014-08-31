require 'rails_helper'

RSpec.describe Challenge, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  before :each do
    @challenge = Challenge.create(title: 'New', start_date: DateTime.now, end_date: DateTime.tomorrow)
    @user = User.create(first_name: 'Joe', last_name: 'Doe', email: 'joe@doe.com', phone_number: '+16505555555', img_url: 'some_url')
    @message = Message.create(text: 'text', is_private: true)
  end

  it "creates a new challenge with a title" do
    expect(@challenge.title).to eql('New')
  end

  it "can create challenge with users" do
    @challenge.users << @user
    expect(@challenge.users.size).to eql(1)
  end

  it "can create a challenge with messages" do
    @challenge.messages << @message
    expect(@challenge.messages.size).to eql(1)
  end

  it "must have a start date" do
    challenge = Challenge.new(title: 'New', end_date: DateTime.now)
    challenge.should_not be_valid
  end

  it "must have an end date" do
    challenge = Challenge.new(title: 'New', start_date: DateTime.now)
    challenge.should_not be_valid
  end

  it "must have an end date greater than start date" do
    challenge = Challenge.new(title: 'New', start_date: DateTime.now, end_date: DateTime.now)
    # challenge.should_not be_valid
    expect(challenge.errors.size).to eql(1)
  end
end
