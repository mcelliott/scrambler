class RoundCreator
  def initialize(event, round_number)
    @event = event
    @round_number = round_number.to_i
  end

  def perform
    Round.create(
      event: @event,
      round_number: @round_number,
      name: "Round #{@round_number}"
    )
  end
end
