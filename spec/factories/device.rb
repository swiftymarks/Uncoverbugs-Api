require 'faker'

FactoryGirl.define do
  factory :device do
    brand Device.random_brand
    model Device.random_model
    browser Device.random_browser
    operating_system Device.random_operating_system
  end
end