class User < ActiveRecord::Base
  has_many :messages
  has_many :user_challenges
  has_many :challenges, :through => :user_challenges
end
