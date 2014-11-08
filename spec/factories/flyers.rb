# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flyer do
    sequence(:name)  { |n| "Flyer #{n}" }
    sequence(:email) { |n| "flyer_#{n}@foo.com" }
    hours 50
    user
  end
end
