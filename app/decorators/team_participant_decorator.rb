class TeamParticipantDecorator < Draper::Decorator
  delegate_all

  decorates_association :participant

  def participant_name
    participant.flyer_name if participant.present?
  end

  def category_name
    participant.category.display_name if participant.present?
  end

  def participant_hours
    participant.flyer_hours if participant.present?
  end

  def participant_number
    participant.number if participant.present?
  end
end
