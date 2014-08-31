class Challenge < ActiveRecord::Base
  has_many :user_challenges
  has_many :messages
  has_many :users, :through => :user_challenges

  validates_presence_of :start_date, :end_date, :title, :status
  validates_inclusion_of :status, :in => ["success", "fail", "open", "done"]

  # validate :end_date_validation

  # def end_date_validation
  #   if start_date and end_date
  #     if end_date <= start_date
  #       errors.add(:end_date, "End date must be later than start date")
  #     end
  #   end
  # end

end
