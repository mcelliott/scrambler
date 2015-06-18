class RoundDecorator < Draper::Decorator
  delegate_all

  def teams
    object.teams.map do |team|
      TeamDecorator.new(team)
    end
  end
end
