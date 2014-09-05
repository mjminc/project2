require 'rails_helper'

RSpec.describe Message, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  before :each do
    @challenge = Challenge.create(title: 'New', start_date: DateTime.now, end_date: DateTime.tomorrow, status: "success")
    @user = User.create(first_name: 'Joe', last_name: 'Doe', email: 'joe@doe.com', phone_number: '+16505555555', img_url: 'some_url')
    @message = Message.create(text: 'text', is_private: true)
  end

  it "should create a new message with text" do
    expect(@message.text).to eql('text')
  end

  it "should require text to make a new message" do
    message = Message.new(is_private: true)
    message.should_not be_valid
  end

  it "should allow appending messages to users" do
    @user.messages << @message
    expect(@user.messages.size).to eql(1)
  end

  it "should allow appending messages to challenges" do
    @challenge.messages << @message
    expect(@challenge.messages.size).to eql(1)
  end
end
