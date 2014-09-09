FactoryGirl.define do

  factory :user do
    email Faker::Internet.email
    phone_number Faker::PhoneNumber.short_phone_number
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    pswrd = "123456"
    password pswrd
    password_confirmation pswrd
  end


end