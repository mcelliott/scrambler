# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    participant_id 1
    event_id 1
    team_name "MyString"
  end
end
