class ParticipantCreator
  attr_reader :participant
  def initialize(event, params)
    @event = event
    @params = params
  end

  def perform
    participant.number = Participant.participant_number(@event)
    participant.create_payment(event: @event, amount: @event.participant_cost)
    participant.save
  end

  def participant
    @participant ||= Participant.new(@params.merge(event_id: @event.id))
  end
end
