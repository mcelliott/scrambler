class RoundGenerator
  attr_reader :event_participants, :event, :rounds

  def initialize(event)
    @event = event
  end

  def perform
    reset
    build_rounds
    populate_rounds
  end

  def print
    rounds.each do |round, teams|
      puts round
      teams.each do |team, participants|
        puts "\t#{team} - #{participants}"
      end
    end
  end

  private

  def reset
    @rounds = {}
    @event_participants = []
  end

  def populate_rounds
    rounds.each do |round, _teams|
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
      round_name = "Round #{r + 1}"
      rounds[round_name] = {}
      number_of_teams.times do |t|
        team_name = "Team #{t + 1}"
        rounds[round_name][team_name] = []
      end
    end
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
    current_round.each do |team, _participants|
      @team = team
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
    unless team_is_full?
      current_team.concat(combination)
      event_participants.push(combination)
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
      participant = combinations.flatten.uniq - current_round.values.flatten
      add_participants(participant) unless flown_in_round?(participant)
    end
  end

  #########################################################
  ### Combinations
  ### an array of unqiue permutations of participant ids
  ### shuffled to randomize the participant order
  #########################################################

  def combinations
    @combinations ||= event.participants.map(&:id).combination(event.team_size).to_a.shuffle
  end

  #########################################################
  ### Flown in Event
  ### check if the combination has together in this event
  #########################################################

  def flown_in_event?(combination)
    event_participants.include?(combination)
  end

  #########################################################
  ### Flown in Round
  ### check if each participant in the combination has
  ### flown in this round.
  #########################################################

  def flown_in_round?(combination)
    return true unless combination
    round_participants = current_round.values.flatten
    combination.any? { |c| round_participants.include?(c) }
  end

  #########################################################
  ### Helper methods
  #########################################################

  def team_is_full?
    current_team.size == event.team_size
  end

  def current_team
    current_round[@team]
  end

  def current_round
    @rounds[@round]
  end

  def number_of_teams
    (event.participants.count / event.team_size.to_f).ceil
  end
end