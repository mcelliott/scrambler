class RoundCreator
  def initialize(event, round_number)
    @event = event
    @round_number = round_number
  end

  def perform
    Round.create!(event: @event, round_number: @round_number + 1)
  end
end
