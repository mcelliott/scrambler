# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    event_date "2014-10-11 23:11:54"
    location "MyString"
    num_rounds 3
    sequence(:name) { |n| "Name #{n}" }
    team_size 2
    user
  end
end
