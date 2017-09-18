require 'faker'

FactoryGirl.define do
  factory :project do
    name Faker::Space.star_cluster
    version Faker::App.version
    testing_site Faker::Internet.url
    objective Faker::Lorem.sentence(100)
    result_email Faker::Internet.safe_email
    testing_type Project.random_testing_type
    language Project.random_language
  end
end