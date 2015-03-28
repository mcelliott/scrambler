class TeamParticipantCreator

  def initialize(event, participant_id, team, placeholder = false)
    @event = event
    @participant_id = participant_id
    @team = team
    @placeholder = placeholder
  end

  def perform
    if @participant_id.present?
      EventScoreCreator.new(@event, team_participant, @team.round).perform
      team_participant
    end
  end

  private
  def team_participant
    @team_participant ||= TeamParticipant.create!(team: @team,
                                                  event: @event,
                                                  participant_id: @participant_id,
                                                  placeholder: @placeholder)
  end
end
