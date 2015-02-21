class EventDecorator < Draper::Decorator
  delegate_all

  decorates_associations :participants, :rounds, :payments

  def participants?
    participants.present?
  end

  def rounds?
    rounds.present?
  end

  def category_participants
    participants.group_by { |p| p.category }
  end

  def round_teams(r)
    r.teams
  end

  def teams_by_category(r)
    round_teams(r).group_by{ |tp| tp.category.name }
  end
end
