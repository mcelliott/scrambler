class TeamCreator
  def initialize(event, category, round)
    @event = event
    @category = category
    @round = round
  end

  def perform
    teams.create(name: "Team #{team_number}", category: @category, round: @round, event: @event)
  end

  private

  def team_number
    teams.count + 1
  end

  def teams
    @round.teams
  end
end
