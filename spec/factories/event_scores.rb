FactoryGirl.define do
  factory :event_score do
    team_participant
    event
    score 1
    round
  end
end
