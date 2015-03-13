class BasicRoundCreator
  attr_reader :event
  def initialize(event, params, team_list)
    @event = event
    @params = params
    @team_list = team_list
    @combinations = {}
  end

  def perform
    round_numbers.each do |num_round|
      round = RoundCreator.new(event, num_round).perform
      event.categories_participants.each do |category, participants|

        number_of_teams(category).times do
          team = TeamCreator.new(event, category, round).perform

          combinations(participants, category.id).each do |team_participants|
            # If they haven't flown in this round,
            # add participants then remove them from the permutations list
            unless has_team_flown_in_round?(round.reload, category, team_participants)

              create_team_participants(team, team_participants)
              combinations(participants, category.id).delete(team_participants)
              break
            end
          end

          # deal with odd teams
          unless team.size == event.team_size
            odd_participants = combinations(participants, category.id).flatten.uniq - round_team_participants(round, category)
            create_team_participants(team, [odd_participants.first])
          end
        end
      end
    end
  end

  private

  def round_numbers
    delete_mixed_rounds
  end

  def output_teams(round)
    puts "Round #{round.round_number}. Teams: "
    round.reload.teams.map do |t|
      print "#{t.name} #{t.reload.team_participants.map { |tp| "#{tp.participant.flyer.name} #{tp.participant_id}" }}"
      puts ''
    end
  end

  def combinations(participants, category_id)
    @combinations[category_id] ||= participants.map(&:id).combination(event.team_size).to_a.shuffle
  end

  def create_team_participants(team, team_participants)
    team_participants.each do |participant_id|
      TeamParticipantCreator.new(event, participant_id, team).perform
    end
  end

  def has_team_flown_in_round?(round, category, team_participants)
    round_team_participants(round, category).any? { |p| team_participants.include? p }
  end

  def round_team_participants(round, category)
    round.reload.teams.for_category(category).map { |team| team.team_participants.map(&:participant_id) }.flatten.uniq
  end

  def number_of_teams(category)
    @number_of_teams = (event.participants.where(category: category).count / event.team_size.to_f).ceil
  end

  def delete_mixed_rounds
    (0..(event.num_rounds - 1)).to_a.delete_if do |round|
      mixed_rounds.include?(round + 1)
    end
  end

  def mixed_rounds
    @params[:mixed_rounds] ? @params[:mixed_rounds].keys.map(&:to_i) : []
  end
end
