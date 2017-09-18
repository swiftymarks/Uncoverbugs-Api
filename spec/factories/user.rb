require 'faker'

FactoryGirl.define do
  factory :user do
    email Faker::Internet.safe_email
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    username Faker::Twitter.screen_name
    password Faker::Internet.password

    trait :admin do
      user_type "admin"
    end

    trait :tester do
      user_type "tester"
    end

    trait :company do
      user_type "company"
    end

    factory :user_company,    traits: [:company]
    factory :user_tester,    traits: [:tester]    
    factory :user_admin,    traits: [:admin]    
    
  end
end