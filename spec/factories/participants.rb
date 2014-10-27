# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participant do
    flyer
    category
    event
    number 10
    user
  end
end
