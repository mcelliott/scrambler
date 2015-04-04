class MixedRoundsGenerator < BaseRoundsGenerator

  def perform
    mixed_rounds.each do |num_round|
      @round = create_round(num_round - 1)
      number_of_teams.times do
        @team = create_team(mixed_freefly_category, @round)
        create_even_team_participants
        create_odd_team_participants
      end
    end
  end

  private

  def create_even_team_participants
    combinations.each do |team_participants|
      if allowed_to_fly_together?(team_participants) && mixed?(team_participants)
        unless has_team_flown_in_round?(team_participants)
          create_team_participants(team_participants, @team)
          combinations.delete(team_participants)
          break
        end
      end
    end
  end

  def create_odd_team_participants
    unless @team.size == event.team_size
      odd_participants = combinations.flatten.uniq - round_team_participants
      create_team_participants([odd_participants.first], @team)
    end
  end

  def has_team_flown_in_round?(team_participants)
    round_team_participants.any? { |p| team_participants.include? p }
  end

  def round_team_participants
    @round.reload.teams.map do |team|
      team.team_participants.map(&:participant)
    end.flatten.uniq
  end

  def number_of_teams
    event.number_of_teams
  end

  def combinations
    @combinations ||= participant_combinations(event.participants)
  end

  def mixed_freefly_category
    @category ||= Category.find_or_create_by(name: 'Mixed',
                                             category_type: CategoryType::MIXED)
  end

  def mixed?(team_participants)
    participant_categories = team_participants.map do |tp|
      Participant.find_by(id: tp).category.name
    end
    participant_categories.count('head_up') == (team_participants.size / 2)
  end

  def allowed_to_fly_together?(team_participants)
    participant_categories = team_participants.map do |tp|
      Participant.find_by(id: tp).category.name
    end
    participant_categories.count('head_up') <= (team_participants.size / 2)
  end
end
