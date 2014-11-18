module TeamsHelper
  def placeholder_text
    "Placeholder, score doesn't count"
  end

  def team_participant_score(tp)
    "#{tp.event_score.score}"
  end
end
