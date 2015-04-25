class TeamParticipantDecorator < Draper::Decorator
  delegate_all

  decorates_association :participant
  delegate :name, to: :participant, prefix: true
  delegate :number, to: :participant, prefix: true
  delegate :display_name, to: :category, prefix: true

  def category_name
    category_display_name
  end

  def participant_hours_humanize
    participant.flyer_hours
  end
end
