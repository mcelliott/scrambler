class TeamCreator
  attr_reader :event, :round, :category, :team_number

  def initialize(team_number, event, round, category)
    @team_number = team_number
    @event = event
    @category = category
    @round = round
  end

  def perform
    teams.create(name: team_name,
                 event: event,
                 round: round,
                 category: category)
  end

  private

  def team_name
    "T#{team_number}"
  end

  def teams
    round.teams
  end
end
