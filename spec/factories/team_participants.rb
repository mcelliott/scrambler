# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_participant do
    event
    participant
    placeholder false
    team
  end
end
