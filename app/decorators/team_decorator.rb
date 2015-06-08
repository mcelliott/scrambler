class TeamDecorator < Draper::Decorator
  delegate_all

  decorates_association :team_participants

  def event_score
    object.team_participants.map do |tp|
      tp.event_score
    end.first || EventScore.new
  end
end
