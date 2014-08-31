class Challenge < ActiveRecord::Base
  has_many :user_challenges
  has_many :users, :though => :user_challenges
end
