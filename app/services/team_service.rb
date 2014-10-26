class TeamService
  def initialize(event)
    @team  = {}
    @event = event
    @user  = event.user
  end

  def create_team_participants
    @event.num_rounds.times do |num_round|
      round = Round.create!(event: @event, user: @user, round_number: num_round + 1)
      event_participants.each { |p| create_participant(p, round) } if round.present?
    end
  end

  private

  def create_event_team(participant, round)
    category_id = participant.category.id
    return @team[category_id] if space_available?(category_id)
    create_team(participant, round)
  end

  def create_team(participant, round)
    round.teams.create(name: "Team #{team_number(round)}",
                       category: participant.category,
                       user: @user,
                       round: round,
                       event: @event)
  end

  def create_participant(participant, round)
    TeamParticipant.create!(user: @user,
                            team: create_event_team(participant, round),
                            event: @event,
                            participant: participant)
  end

  def space_available?(category_id)
    @team[category_id].team_participants.count < @event.team_size if @team.key?(category_id)
  end

  def team_number(round)
    round.teams.count + 1
  end

  def event_participants
    @event.participants.shuffle
  end
end
