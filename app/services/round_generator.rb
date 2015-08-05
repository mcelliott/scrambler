class RoundGenerator
  attr_reader :event_participants, :event, :mixed_rounds

  def initialize(event, mixed_rounds = [])
    @event = event
    @mixed_rounds = mixed_rounds
    reset
  end

  def generate
    reset
    build
    combination_generator.generate
    populate_rounds
  end

  def build
    round_builder.build
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

  def check_rounds
    team_list = []
    rounds.each do |_, teams|
      teams.each do |_, categories|
        categories.each do |_, participants|
          team_list << participants.map(&:id)
        end
      end
    end
    dups = team_list.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)
    dups.delete_if { |participants| participants.size == 1 }
    if dups.size > 0
      Rails.logger.error("Team List is not uniq: #{dups}")
    end
  end

  def rounds
    round_builder.rounds
  end

  private

  def reset
    @event_participants = []
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
    round_builder.build
  end

  def round_builder
    @round_builder ||= RoundBuilder.new(event, mixed_rounds)
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
        add_participants(combination)
      end
    end
    populate_empty_team
  end

  def add_participants(combination)
    unless team_is_full? || cannot_fly_together?(combination)
      current_team.concat(combination)
      if (combination.size > 1)
        event_participants.push(combination.map(&:id))
        combination.delete(combination)
      end
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
      available_participants = participants_remaining
      if available_participants.size > 1
        remaining_combinations = available_participants.combination(event.team_size)
        remaining_combinations.each do |combination|
          participants = combination[0, slots_remaining]
          unless flown_in_event?(participants) || flown_in_round?(participants)
            add_participants(participants)
          end
        end
      else
        participants = available_participants[0, slots_remaining]
        unless flown_in_round?(participants)
          add_participants(participants)
        end
      end
    end
  end

  def participants_remaining
    combinations.flatten.uniq - current_round.values.map(&:values).flatten
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
    combination_generator.mixed_combinations
  end

  def combinations
    combination_generator.combinations[@current_category]
  end

  def generate_category_combinations
    combination_generator.generate
  end

  def combination_generator
    @combination_generator ||= CombinationGenerator.new(event)
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
    head_up_participants = combination_category(combination, 'head_up')
    head_down_participants = combination_category(combination, 'head_down')

    valid_mixed?(head_up_participants) ||
    team_is_head_down?(head_down_participants) ||
    (combination.size == 1)
  end

  def cannot_fly_together?(combination)
    !can_fly_together?(combination)
  end

  def team_is_head_down?(participants)
    participants.size == event.team_size
  end

  def valid_mixed?(participants)
    participants.size <= (event.team_size / 2)
  end

  def combination_category(combination, name)
    combination.map do |p|
      p if p.category.name == name
    end.compact
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
    rounds[@round]
  end
end
