class TeamService
  def initialize(event)
    @team  = {}
    @event = event
  end

  def create_team_participants
    @event.num_rounds.times do |num_round|
      participant_list = []
      round = Round.create!(event: @event, user: @event.user, round_number: num_round + 1)
      @event.user.categories.each do |category|
        category_participants = unique_participants_teams(category)
        number_of_teams(category).times do |n|

          create_team(category, round)
          team = nil
          i = 0
          singles = false

          loop do

            if i >= category_participants.size
              singles = true
              i = 0
            end

            next_participants = category_participants[i]
            if has_flown?(next_participants, participant_list)
              unless singles
                i += 1
                next
              end
            end

            team = new_team_members(participant_list, category, i)
            i += 1

            break unless team.empty? || participant_list.include?(team)
          end

          unique_participants_teams(category).delete_at(i-1)
          if team.present?
            participant_list << team
            team.each do |participant_id|
              create_participant(participant_id, round)
            end
          end
        end
      end
    end
  end

  private

  def has_flown?(team, participant_list)
    team.any? { |p| participant_list.flatten.include? p } if team.present?
  end

  def new_team_members(participant_list, category, index)


    team = []
    unique_participants_teams(category)[index].each do |p|
      (team << p) unless participant_list.flatten.include?(p)
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

  def create_event_team(participant, round)
    category_id = participant.category.id
    return @team[category_id] if space_available?(category_id)
    @team[category_id] = create_team(participant.category, round)
  end

  def create_participant(participant_id, round)
    participant = @event.participants.find participant_id
    TeamParticipant.create!(user: @event.user,
                            team: round.teams.last,
                            event: @event,
                            participant: participant) if participant.present?
  end

  def space_available?(category_id)
    (@team[category_id].team_participants.count < @event.team_size) if @team.key?(category_id)
  end

  def team_number(round)
    round.teams.count + 1
  end

  def event_participants
    @event.participants.shuffle
  end

  def number_of_teams(category)
    (@event.participants.where(category: category).count / @event.team_size.to_f).ceil
  end

  def build_participants
    participant_teams = {}
    p_list = product_of_participants.delete_if { |pl| pl.uniq.size <  @event.team_size }.map { |p| p.sort }.uniq
    p_list.map { |p| (participant_teams[p.first] ||= []).concat(p[1..p.size]) }
    participant_teams
  end

  def unique_participants_teams(category)
    @unique_participants ||= product_of_participants(category).delete_if { |pl| pl.uniq.size <  @event.team_size }.map { |p| p.sort }.uniq
  end

  def product_of_participants(category)
    ids = @event.participants.category_type(category).shuffle.map(&:id)
    ids.product(ids)
  end

end
