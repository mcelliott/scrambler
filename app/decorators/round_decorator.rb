class RoundDecorator < Draper::Decorator
  delegate_all
  decorates_association :teams
end
