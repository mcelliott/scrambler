class RoundGenerator
  attr_reader :event_participants, :event, :rounds, :mixed_rounds

  def initialize(event, mixed_rounds = [])
    @event = event
    @mixed_rounds = mixed_rounds
    reset
  end

  def perform
    reset
    build_rounds
    generate_category_combinations
    populate_rounds
  end

  def print
    str = ""
    rounds.each do |round, teams|
      str += "Round #{round}\n"
      teams.each do |team, categories|
        str += "---- Team #{team} - "
        categories.each do |category, participants|
          str += "#{category} - "
          str += participants.map { |p| "#{p.id} #{p.category.name}" }.to_s
          str += "\n"
        end
      end
    end
    puts str
  end

  private

  def reset
    @rounds = {}
    @event_participants = []
    @combinations = {}
    @current_category = nil
  end

  def populate_rounds
    rounds.each do |round, _|
      @round = round
      populate_round
    end
  end

  #########################################################
  ### Initialize rounds
  ### generate stubs up front for all rounds and teams
  ###
  ### Number of rounds - Event#num_rounds
  ### Team size - see: def number_of_teams; end
  #########################################################

  def build_rounds
    event.num_rounds.times do |r|
      round_name = "#{r + 1}"
      rounds[round_name] = {}
      team_number = 1
      Category.all.each do |category|
        number_of_teams(category).times do
          team_name = "#{team_number}"
          rounds[round_name][team_name] = {}
          category_name = mixed_round?("#{r + 1}") ? CategoryType::MIXED : category.name
          rounds[round_name][team_name][category_name] = []
          team_number += 1
        end
      end
    end
    puts rounds
  end

  def mixed_round?(number)
    @mixed_rounds.include?(number)
  end

  def number_of_teams(category)
    event.number_of_teams_by_category(category.id)
  end

  #########################################################
  ### Populate
  ### populate the rounds from the combinations with
  ### the following rules:
  ###
  ### 1. teams must be unique across rounds
  ### 2. participants may only fly once per round
  ### 3. odd numbers result in odd team size
  #########################################################

  def populate_round
    current_round.each do |team, _|
      @team = team
      @current_category = current_round[@team].keys.first
      populate_team
    end
  end

  def populate_team
    combinations.each do |combination|
      unless flown_in_event?(combination) || flown_in_round?(combination)
        add_participants(combination) if can_fly_together?(combination)
      end
    end
    populate_empty_team
  end

  def add_participants(combination)
    unless team_is_full?
      current_team.concat(combination)
      event_participants.push(combination.map(&:id))
    end
  end

  #########################################################
  ### Empty Teams
  ### teams can contain an odd number of participants
  ### if the number of participants doesn't mapped evenly
  ### to the number of teams in a round
  #########################################################

  def populate_empty_team
    unless team_is_full?
      participant = participants_remaining[0, slots_remaining]
      add_participants(participant) unless flown_in_round?(participant)
    end
  end

  def participants_remaining
    combinations.flatten.uniq - current_round.values.map(&:values).flatten
  end

  def combinations
    @combinations[@current_category]
  end

  def slots_remaining
    event.team_size - current_team.size
  end

  #########################################################
  ### Combinations
  ### an array of unqiue permutations of participant ids
  ### shuffled to randomize the participant order
  #########################################################

  def mixed_combinations
    @mixed_combinations ||= event.participants.
      combination(event.team_size).
      to_a.shuffle
  end

  def generate_category_combinations
    event.categories_participants.each do |category, participants|
      @combinations[category.name] = participants.
        combination(event.team_size).
          to_a.shuffle
    end
    @combinations[CategoryType::MIXED] = mixed_combinations
  end

  #########################################################
  ### Flown in Event
  ### check if the combination has together in this event
  #########################################################

  def flown_in_event?(combination)
    event_participants.include?(combination.map(&:id))
  end

  #########################################################
  ### Flown in Round
  ### check if each participant in the combination has
  ### flown in this round.
  #########################################################

  def flown_in_round?(combination)
    return true unless combination
    round_participants = current_round.values.map(&:values).flatten
    combination.any? { |c| round_participants.include?(c) }
  end

   #########################################################
  ### Can Fly Together
  ### Specific to mixed teams. Head up must fly with
  ### head down. Cannot have all head up flyers
  #########################################################

  def can_fly_together?(combination)
    return true unless @current_category == CategoryType::MIXED
    head_up_participants = combination.map do |p|
      p if p.category.name == 'head_up'
    end.compact
    head_up_participants.size <= (event.team_size / 2)
  end

  #########################################################
  ### Helper methods
  #########################################################

  def team_is_full?
    current_team.size == event.team_size
  end

  def current_team
    current_round[@team][@current_category] ||= []
  end

  def current_round
    @rounds[@round]
  end
end