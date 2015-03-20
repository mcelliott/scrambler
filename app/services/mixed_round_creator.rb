class MixedRoundCreator
  attr_reader :event
  def initialize(event, params)
    @event = event
    @params = params
  end

  def perform
    puts "Starting MixedRoundCreator perform"
    round_numbers.each do |num_round|
      round = RoundCreator.new(event, num_round - 1).perform
      number_of_teams.times do
        team = TeamCreator.new(event, mixed_freefly_category, round).perform

        combinations.each do |team_participants|
          if allowed_to_fly_together?(team_participants) && mixed?(team_participants)
            unless has_team_flown_in_round?(round.reload, team_participants)
              create_team_participants(team, team_participants)
              combinations.delete(team_participants)
              break
            end
          end
        end

        # deal with odd teams
        unless team.size == event.team_size
          odd_participants = combinations.flatten.uniq - round_team_participants(round)
          create_team_participants(team, [odd_participants.first])
        end
      end
    end
    puts "Finished MixedRoundCreator perform"
  end

  private

  def create_team_participants(team, team_participants)
    team_participants.each do |participant|
      TeamParticipantCreator.new(event, participant.id, team).perform
    end
  end

  def has_team_flown_in_round?(round, team_participants)
    round_team_participants(round).any? { |p| team_participants.include? p }
  end

  def round_team_participants(round)
    round.reload.teams.map { |team| team.team_participants.map(&:participant_id) }.flatten.uniq
  end

  def number_of_teams
    @number_of_teams = (event.participants.count / event.team_size.to_f).ceil
  end

  def combinations
    (@combinations ||= event.participants.map(&:id).combination(event.team_size).to_a.map { |tp| Participant.find(tp) }).shuffle
  end

  def round_numbers
    @params[:mixed_rounds] ? @params[:mixed_rounds].keys.map(&:to_i) : []
  end

  def mixed_freefly_category
    @category ||= Category.find_or_create_by(name: 'Mixed', category_type: CategoryType::MIXED)
  end

  def mixed?(team_participants)
    participant_categories = team_participants.map { |tp| Participant.find_by(id: tp).category.name }
    participant_categories.count('head_up') == (team_participants.size / 2)
  end

  def allowed_to_fly_together?(team_participants)
    participant_categories = team_participants.map { |tp| Participant.find_by(id: tp).category.name }
    participant_categories.count('head_up') <= (team_participants.size / 2)
  end
end
