require 'faker'

FactoryGirl.define do
  factory :brand do
    name Brand.random_name
  end
end