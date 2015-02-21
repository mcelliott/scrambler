class CategoryTeamCreator
  def initialize(event, category, round)
    @event = event
    @category = category
    @round = round
  end

  def perform

  end

  private

  def create_category_teams(category, round)
    number_of_teams(category).times do
      upt = unique_participants_teams(category).shuffle
      upt.each do |team|
        unless has_flown?(team)
          create_and_populate_team(category, round, team)
          upt.delete(team)
        end
      end
    end

    unless round.teams.size == number_of_teams(category)
      create_and_populate_team(category, round, new_team_members(category)) if event.participants.category_type(category).present?
    end
  end

  def create_and_populate_team(category, round, team)
    return nil unless team.present?
    TeamCreator.new(event, category, round, team).perform { |participant_id| @team_participant_list << participant_id }
    unique_participants_teams(category).delete(team)
  end

  def number_of_teams(category)
    (@event.participants.where(category: category).count / @event.team_size.to_f).ceil
  end

  def unique_participants_teams(category)
    @unique_participants[category] ||= product_of_participants(category).delete_if do |pl|
      pl.uniq.size <  event.team_size
    end.map { |p| p.sort }.uniq
  end
end
