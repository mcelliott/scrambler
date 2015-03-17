class MixedRoundCreator
  attr_reader :event
  def initialize(event, params, team_list)
    @event = event
    @params = params
    @team_list = team_list
  end

  def perform
    return unless @params[:mixed_rounds]
    # create teams that are mixed head up / head down
    # can't have a team where head up flyers count is greater than (team_size / 2)
    ## sit cannot do head down moves

    round_numbers.each do |num_round|
      round = RoundCreator.new(event, num_round).perform
      number_of_teams.times do
        team = TeamCreator.new(event, mixed_freefly_category, round).perform

        combinations.each do |team_participants|
          # If they haven't flown in this round,
          # add participants then remove them from the permutations list
          unless has_team_flown_in_round?(round.reload, team_participants)
            create_team_participants(team, team_participants)
            combinations.delete(team_participants)
            break
          end
        end

        # deal with odd teams
        unless team.size == event.team_size
          odd_participants = combinations.flatten.uniq - round_team_participants(round)
          create_team_participants(team, [odd_participants.first])
        end
      end
    end
  end

  private

  def create_team_participants(team, team_participants)
    team_participants.each do |participant_id|
      TeamParticipantCreator.new(event, participant_id, team).perform
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
    @combinations ||= event.participants.map(&:id).combination(event.team_size).to_a.shuffle
  end

  def round_numbers
    @params[:mixed_rounds].keys.map(&:to_i)
  end

  def mixed_freefly_category
    @category ||= Category.find_or_create_by(name: 'Mixed', category_type: CategoryType::MIXED)
  end

  def not_
    
  end
end
