require 'rails_helper'

RSpec.describe User, :type => :model do

  subject { FactoryGirl.create(:user)}

  it "should have a valid factory" do
    expect(subject).to be_valid
  end

  it "should validate a password at 6 characters" do
    expect(subject.password.length).to eql(6)
  end

  it "should be able to have a challenge" do

  end

end
