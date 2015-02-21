class TeamService
  def initialize(event, category)
    @event = event
    @category = category
    @unique_participants = {}
  end

  def shuffled_participants_teams
    unique_participants_teams.shuffle
  end

  def unique_participants_teams
    @unique_participants[@category.id] ||= product_of_participants.delete_if do |pl|
      pl.uniq.size < @event.team_size
    end.map { |p| p.sort }.uniq
  end

  def product_of_participants
    ids = @event.participants.category_type(@category).shuffle.map(&:id)
    ids.product(ids)
  end

  def number_of_teams
    @number_of_teams ||= (@event.participants.where(category: @category).count / @event.team_size.to_f).ceil
  end
end
