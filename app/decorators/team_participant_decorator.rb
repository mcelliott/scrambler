class TeamParticipantDecorator < Draper::Decorator
  delegate_all

  def participant_name
    participant.flyer.name if participant.present?
  end

  def category_name
    participant.category.name if participant.present?
  end

  def participant_hours
    participant.flyer.hours.ceil if participant.present?
  end

  def participant_number
    participant.number if participant.present?
  end
end
