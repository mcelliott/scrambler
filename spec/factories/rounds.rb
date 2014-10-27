# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :round do
    user
    event
    sequence(:round_number) { |n| n }
  end
end
