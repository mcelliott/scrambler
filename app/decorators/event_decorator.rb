class EventDecorator < Draper::Decorator
  delegate_all

  decorates_association :participants
  decorates_association :rounds

  def participants?
    participants.present?
  end

  def category_participants
    participants.group_by { |p| p.category }
  end
end
