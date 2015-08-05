# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flyer do
    sequence(:name)  { Faker::Name.name }
    sequence(:email) { Faker::Internet.email }
    hours TunnelHours::NOVICE
  end
end
