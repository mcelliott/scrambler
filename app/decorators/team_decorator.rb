class TeamDecorator < Draper::Decorator
  delegate_all

  decorates_association :team_participants
end
