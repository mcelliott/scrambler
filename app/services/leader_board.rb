class LeaderBoard
  def initialize(event)
    @event = event
  end

  def results
    participants.map do |participant|
      LeaderBoardParticipant.new(@event, participant)
    end.sort { |a, b|  b.total_score <=> a.total_score }
  end

  private

  def participants
    @participants ||= @event.participants
  end
end
