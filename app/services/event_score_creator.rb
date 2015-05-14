class EventScoreCreator
  attr_reader :team_participant

  def initialize(team_participant)
    @team_participant = team_participant
  end

  def save
    team_participant.build_event_score(round: round,
                                       event: event,
                                       participant: participant,
                                       score: 0).save
  end

  private

  def round
    team_participant.team.round
  end

  def event
    team_participant.event
  end

  def participant
    team_participant.participant
  end
end
