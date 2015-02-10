class EventDecorator < Draper::Decorator
  delegate_all

  decorates_association :participants
  decorates_association :rounds
end
