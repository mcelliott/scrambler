class TeamParticipantPresenter < BasePresenter
  def initialize(event)
    super event
  end

  def event
    @object
  end

  def rounds
    @rounds ||= event.rounds
  end

  def teams(r)
    @teams = r.teams.includes(:team_participants)
  end

  def teams_by_category(r)
    teams(r).group_by{ |tp| tp.category.name }
  end
end
