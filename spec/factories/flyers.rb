# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flyer do
    sequence(:name) { |n| "Flyer #{n}" }
    hours 50
    user
  end
end
