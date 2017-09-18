require 'faker'

FactoryGirl.define do
  factory :notification_setting do
    newsletter Faker::Boolean.boolean
    notify_new_project Faker::Boolean.boolean
    notify_work_evaluation Faker::Boolean.boolean
    notify_events Faker::Boolean.boolean
  end
end