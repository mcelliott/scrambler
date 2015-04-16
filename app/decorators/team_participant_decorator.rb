class TeamParticipantDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
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

  def data
    {
      name: participant_name,
      category: category_name,
      number: participant_name,
      hours: participant_hours,
      path: destroy_teams_participant_path(team_id: team.id, id: object.id)
    }
  end
end
