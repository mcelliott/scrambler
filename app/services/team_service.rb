class TeamService
  def initialize(event)
    @team  = {}
    @event = event
    @unique_participants = {}
  end

  def create_team_participants
    @event.num_rounds.times do |num_round|
      @team_participant_list = []
      round = Round.create!(event: @event, user: @event.user, round_number: num_round + 1)
      @event.user.categories.each do |category|
        create_category_teams(category, round)
      end
    end
  end

  private

  def create_category_teams(category, round)
    number_of_teams(category).times do
      upt = unique_participants_teams(category).shuffle
      upt.each do |team|
        unless has_flown?(team)
          create_and_populate_team(category, round, team)
          upt.delete(team)
        end
      end

    end

    unless round.teams.size == number_of_teams(category)
      create_and_populate_team(category, round, new_team_members(category)) if @event.participants.category_type(category).present?
    end
  end

  def create_and_populate_team(category, round, team)
    return nil unless team.present?
    create_team(category, round)
    team.each do |participant_id|
      create_participant(participant_id, round)
      @team_participant_list << participant_id
    end
    unique_participants_teams(category).delete(team)
  end

  def has_flown?(team)
    team.any? { |p| @team_participant_list.flatten.include? p } if team.present?
  end

  def new_team_members(category)
    i = 0
    return nil unless unique_participants_teams(category)[i]
    team = []
    loop do
      unique_participants_teams(category)[i].each do |p|
        (team << p) unless @team_participant_list.flatten.include?(p)
      end
      i += 1
      break if team.present? || i >= unique_participants_teams(category).size
    end
    team
  end

  def create_team(category, round)
    round.teams.create(name: "Team #{team_number(round)}",
                       category: category,
                       user: @event.user,
                       round: round,
                       event: @event)
  end

  def create_participant(participant_id, round)
    participant = @event.participants.find participant_id
    if participant.present?
      tp = TeamParticipant.create!(user: @event.user,
                                   team: round.teams.last,
                                   event: @event,
                                   participant: participant)
      create_event_score(tp, round)
      tp
    end
  end

  def create_event_score(team_participant, round)
    EventScore.create!(user: @event.user,
                       team_participant: team_participant,
                       round: round,
                       event: @event,
                       participant: team_participant.participant,
                       score: 0)
  end

  def team_number(round)
    round.teams.count + 1
  end

  def number_of_teams(category)
    (@event.participants.where(category: category).count / @event.team_size.to_f).ceil
  end

  def unique_participants_teams(category)
    @unique_participants[category] ||= product_of_participants(category).delete_if do |pl|
      pl.uniq.size <  @event.team_size
    end.map { |p| p.sort }.uniq

  end

  def product_of_participants(category)
    ids = @event.participants.category_type(category).shuffle.map(&:id)
    ids.product(ids)
  end
end
