require 'faker'

FactoryGirl.define do
  factory :tester do
    address1 Faker::Address.street_address + Faker::Address.city + Faker::Address.state + Faker::Address.country
    address2 Faker::Address.street_address + Faker::Address.city + Faker::Address.state + Faker::Address.country
    province Faker::Address.state
    skype_id Faker::Twitter.screen_name
    zip_code Faker::Address.zip_code
    mobile_number Faker::PhoneNumber.cell_phone
    born_year Faker::Number.between(1, 10)
    paypal_email Faker::Internet.safe_email

    trait :male do
      gender "male"
    end

    trait :female do
      gender "female"
    end

    trait :any do
      gender "any"
    end

    factory :tester_male, traits: [:male]
    factory :tester_female, traits: [:female]
    factory :tester_any, traits: [:any]
    
  end
end