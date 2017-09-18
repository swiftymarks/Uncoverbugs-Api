require 'faker'

FactoryGirl.define do
  factory :company do
    company_name Faker::Company.name
    company_url Faker::Internet.url
  end
end