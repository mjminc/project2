FactoryGirl.define do

  STATUS = ["done", "success", "fail", "open"]

  factory :challenge do
    title Faker::Lorem.words(3)
    challenge_amount 100
    charity_id Faker::Lorem.words(1)
    status STATUS.sample
    start_date DateTime.now
    end_date DateTime.now + 1.day
    supporter_amount 100
  end
end