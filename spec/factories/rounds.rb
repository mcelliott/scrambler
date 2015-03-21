# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :round do
    event
    sequence(:round_number) { |n| n }
  end
end
