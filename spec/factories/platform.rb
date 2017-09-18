require 'faker'

FactoryGirl.define do
  factory :platform do
    name Platform.random_name
  end
end