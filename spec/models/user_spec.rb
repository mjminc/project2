require 'rails_helper'

RSpec.describe User, :type => :model do

  subject { FactoryGirl.create(:user)}

  it "should have a valid factory" do
    expect(subject).to be_valid
  end

  it "should validate a password at 6 characters" do
    expect(subject.password.length).to eql(6)
  end

  it "should not allow duplicate emails" do
    user1 = FactoryGirl.create(:user)
    user1.email = "email@email.com"
    user2 = FactoryGirl.build(:user)
    user2.email = "email@email.com"

    expect(user2.save).to raise_error
  end

end
