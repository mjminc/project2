require 'rails_helper'

RSpec.describe Message, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  before :each do
    @challenge = Challenge.create(title: 'New', start_date: Time.now, end_date: Time.now + 1)
    @user = User.create(first_name: 'Joe', last_name: 'Doe', email: 'joe@doe.com', phone_number: '+16505555555', img_url: 'some_url')
    @message = Message.create(text: 'text', is_private: true)
  end

  it "should create a new message with text" do
    expect(@message.text).to eql('text')
  end
end
