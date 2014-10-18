# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :participant do
    name "MyString"
    hours "9.99"
    skill_id 1
  end
end
