class EventScoreCreator
  def initialize(event, team_participant, round)
    @event = event
    @team_participant = team_participant
    @round = round
  end

  def perform
    EventScore.create!(team_participant: @team_participant,
                       round: @round,
                       event: @event,
                       participant: @team_participant.participant,
                       score: 0)
  end
end
