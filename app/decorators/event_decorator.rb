class EventDecorator < Draper::Decorator
  delegate_all

  decorates_association :participants
  decorates_association :rounds
  decorates_association :payments

  def participants?
    participants.present?
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
