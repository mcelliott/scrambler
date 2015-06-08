class LeaderBoardParticipant
  def initialize(event, participant)
    @event = event
    @participant = participant
  end

  def name
    flyer.name
  end

  def category
    @participant.category.name.humanize
  end

  def score
    @score ||= @event.event_scores.where(participant_id: @participant.id).sum(:score).round
  end

  def handicap
    @handicap ||= Handicap.find_by(hours: flyer.hours).amount.round
  end

  def round_scores
    @event.event_scores.includes(:round).
      where(participant_id: @participant.id).
        order('rounds.round_number')
  end

  def total_score
    score - handicap
  end

  def flyer
    @flyer ||= @participant.flyer
  end
end
