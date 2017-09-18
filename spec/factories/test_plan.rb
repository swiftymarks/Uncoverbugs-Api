require 'faker'

FactoryGirl.define do
  factory :test_plan do
    name Faker::StarTrek.specie
    testing_url Faker::Internet.url
    step_explanation Faker::Lorem.sentence(100)
    minimum_time Faker::Number.between(1, 100)
    is_fix true
    script_file Faker::Internet.url
    
    trait :explatory do
      testing_type "explatory"
    end
    
    trait :case_driven do
      testing_type "case_driven"
    end
    
    factory :test_plan_explatory, traits: [:explatory]
    factory :test_plan_case_driven, traits: [:case_driven]
  end
end