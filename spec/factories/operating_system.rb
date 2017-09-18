require 'faker'

FactoryGirl.define do
  factory :operating_system do
    name OperatingSystem.random_name
  end
end