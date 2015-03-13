class ParticipantCreator
  attr_reader :participant
  def initialize(event, user, params)
    @event = event
    @params = params
    @user = user
  end

  def perform
    participant = @user.participants.build(@params.merge(event_id: @event.id))
    participant.number = Participant.participant_number(@event)
    participant.create_payment(event: @event, amount: @event.participant_cost)
    participant.save!
  end
end
