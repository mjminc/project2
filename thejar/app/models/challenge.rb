class Challenge < ActiveRecord::Base
  has_many :user_challenges
  has_many :messages
  has_many :users, :through => :user_challenges

  validates_presence_of :start_date, :end_date
end
