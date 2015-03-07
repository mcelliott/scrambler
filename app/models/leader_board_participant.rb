class LeaderBoardParticipant
  def initialize(event, participant)
    @event = event
    @participant = participant
  end

  def name
    flyer.name
  end

  def score
    @score ||= EventScore.where(participant_id: @participant.id).sum(:score)
  end

  def handicap
    @handicap ||= Handicap.find_by(hours: flyer.hours).amount
  end

  def total_score
    score - handicap
  end

  def flyer
    @flyer ||= @participant.flyer
  end
end
