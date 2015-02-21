class TeamCreator
  def initialize(event, category, round)
    @event = event
    @category = category
    @round = round
  end

  def perform
    teams.create!(name: "Team #{team_number}", category: @category, user: @event.user, round: @round, event: @event)
  end

  private

  def team_number
    @event.teams.where(category: @category, round: @round).count + 1
  end

  def teams
    @round.teams
  end
end
