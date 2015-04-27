class RoundsGenerator < BaseRoundsGenerator
  def initialize(event, params)
    super(event, params)
    @combinations = {}
  end

  def perform
    round_numbers.each do |num_round|
      @round = create_round(num_round)
      event.categories_participants.each do |category, participants|
        number_of_teams(category).times do
          @team = create_team(category, @round)
          create_even_team_participants(participants, category)
          create_odd_team_participants(participants, category)
        end
      end
    end
  end

  private

  def create_even_team_participants(participants, category)
    combinations(participants, category.id).each do |team_participants|
      # If they haven't flown in this round,
      # add participants then remove them from the permutations list
      unless has_team_flown_in_round?(category, team_participants)
        create_team_participants(team_participants, @team)
        combinations(participants, category.id).delete(team_participants)
        break
      end
    end
  end

  def create_odd_team_participants(participants, category)
    unless @team.size == event.team_size
      odd_participants = combinations(participants, category.id).flatten.uniq - round_team_participants(category)
      create_team_participants([odd_participants.first], @team)
    end
  end

  def combinations(participants, category_id)
    @combinations[category_id] ||= participant_combinations(participants).to_a.shuffle
  end

  def has_team_flown_in_round?(category, team_participants)
    round_team_participants(category).any? { |p| team_participants.include? p }
  end

  def round_team_participants(category)
    @round.reload.teams.for_category(category).map do |team|
      team.team_participants.map(&:participant)
    end.flatten.uniq
  end

  def number_of_teams(category)
    event.number_of_teams_by_category(category.id)
  end

  def round_numbers
    (0..(event.num_rounds - 1)).to_a.delete_if do |round|
      mixed_rounds.include?(round + 1)
    end
  end
end
