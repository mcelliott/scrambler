class EmailService
  def initialize(params)
    @params = params
  end

  def send
    if participant_email?
      SendEventWorker.perform_async(event.id, participant.id)
      participant.update_attributes(email_count: participant.email_count + 1)
    else
      SendEventWorker.perform_async(event.id)
      event.update_attributes(email_count: event.email_count + 1)
    end
  end

  def email_already_sent?
    if participant_email?
      participant.email_count > 0
    else
      event.email_count > 0
    end
  end

  def participant_email?
    participant.present?
  end

  def event
    @event ||= Event.includes(:rounds, :participants).find_by(id: @params[:event_id])
  end

  def participant
    @participant ||= event.participants.find_by(id: @params[:participant_id])
  end
end
