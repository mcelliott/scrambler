class TeamParticipantCreator

  def initialize(event, round, participant_id, team)
    @event = event
    @round = round
    @participant_id = participant_id
    @team = team
  end

  def perform
    if @participant_id.present?
      EventScoreCreator.new(@event, team_participant, @round).perform
      team_participant
    end
  end

  private

  def user
    @event.user
  end

  def team_participant
    @team_participant ||= TeamParticipant.create!(user: user, team: @team, event: @event, participant_id: @participant_id)
  end
end
