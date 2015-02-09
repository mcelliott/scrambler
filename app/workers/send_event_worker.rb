class SendEventWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'event_email'
  sidekiq_options retry: false

  def perform(event_id, participant_id=nil)
    load_data(event_id, participant_id)
    if @participant
      deliver_email(@participant)
    else
      @event.participants.each { |p| deliver_email(p) }
    end
  end

  private

  def load_data(event_id, participant_id)
    @event = Event.includes(:rounds, :participants).find(event_id)
    @participant = @event.participants.find(participant_id) if participant_id.present?
  end

  def deliver_email(participant)
    Rails.logger.info("Sending email to #{participant.flyer.name} for event #{@event.name}")
    EventMailer.team_email(participant.id).deliver
  end
end
