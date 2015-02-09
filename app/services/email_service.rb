class EmailService
  def initialize(params)
    @params = params
  end

  def send
    if participant_email?
      SendEventWorker.perform_async(event.id, participant.id)
    elsif email_already_sent?
      Rails.logger.info("Already sent group email for event #{event.name}")
    else
      SendEventWorker.perform_async(@event.id)
      @event.update_attributes(email_count: @event.email_count + 1)
    end
  end

  private

  def event
    @event ||= Event.includes(:rounds, :participants).find @params[:event_id]
  end

  def participant
    @participant ||= event.participants.find(@params[:participant_id])
  end

  def participant_email?
    @params[:participant_id].present?
  end

  def email_already_sent?
    event.email_count > 0
  end
end
