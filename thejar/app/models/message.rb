class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge

  # validations
  validates_presence_of :text
end
