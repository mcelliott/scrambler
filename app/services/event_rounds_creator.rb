class EventRoundsCreator
  def initialize(params)
    ActiveRecord::Base.logger.level = 1
    @params = params
    @permutations = {}
    @team_list = []
  end

  def reset
    event.rounds.destroy_all if event.rounds.present?
  end

  def perform
    event.num_rounds.times do |num_round|
      round = RoundCreator.new(event, num_round).perform
      event.categories_participants.each do |category, participants|

        number_of_teams(category).times do
          team = TeamCreator.new(event, category, round).perform

          combinations(participants, category.id).each do |team_participants|
            # If they haven't flown in this round,
            # add participants then remove them from the permutations list
            unless has_team_flown_in_round?(round.reload, category, team_participants)
              puts "adding participants #{team_participants}"
              create_team_participants(round, team, team_participants)
              combinations(participants, category.id).delete(team_participants)
              break
            end
          end

          # deal with odd teams
          unless team.size == event.team_size
            odd_participants = combinations(participants, category.id).flatten.uniq - round_team_participants(round, category)
            create_team_participants(round, team, [odd_participants.first])
          end
        end
      end
    end
    check_for_dups
  end


  def event
    @event ||= Event.includes(:rounds, :participants).find(@params[:event_id])
  end

  private

  def check_for_dups
    event.teams.map { |team| team.team_participants.map(&:participant_id) }.sort
  end

  def output_teams(round)
    puts "Round #{round.round_number}. Teams: "
    round.reload.teams.map do |t|
      print "#{t.name} #{t.reload.team_participants.map { |tp| "#{tp.participant.flyer.name} #{tp.participant_id}" }}"
      puts ''
    end
  end

  def combinations(participants, category_id)
    @permutations[category_id] ||= participants.map(&:id).combination(event.team_size).to_a.shuffle
  end

  def create_team_participants(round, team, team_participants)
    team_participants.each do |participant_id|
      TeamParticipantCreator.new(event, round, participant_id, team).perform
    end
  end

  def has_flown?(team)
    team.any? { |p| @team_list.flatten.include? p } if team.present?
  end

  def has_team_flown_in_round?(round, category, team_participants)
    round_team_participants(round, category).any? { |p| team_participants.include? p }
  end

  def has_participant_flown_in_round?(round, participant, category)
    round_team_participants(round, category).include? participant
  end

  def round_team_participants(round, category)
    round.reload.teams.for_category(category).map { |team| team.team_participants.map(&:participant_id) }.flatten.uniq
  end

  def number_of_teams(category)
    @number_of_teams = (@event.participants.where(category: category).count / @event.team_size.to_f).ceil
  end

  def num_permutations
    -> (n,r) { factorial(n) / factorial(n - r) }
  end

  def num_combinations
    -> (n, r) { factorial(n) / (factorial(n - r) * factorial(r)) }
  end

  def factorial(x)
    x.downto(1).inject(:*)
  end
end
