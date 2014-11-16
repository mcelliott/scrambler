module TeamsHelper
  def placeholder_text
    "Placeholder, score doesn't count"
  end

  def team_participant_score(p)
    p.event_score || 0
  end
end
