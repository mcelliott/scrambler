class SendEventWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'event_email'
  sidekiq_options retry: false

  def perform(event_id)
    event = Event.includes(:rounds, :participants).find event_id
    event.participants.each do |participant|
      EventMailer.team_email(participant.id).deliver
    end
  end
end
