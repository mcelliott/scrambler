class EmailServiceDecorator
  include Rails.application.routes.url_helpers
  attr_reader :email_service, :confirm, :info

  def initialize(email_service)
    @email_service = email_service
    set_content
  end

  def send_path
    event_email_path(event_id, participant_id: participant_id)
  end

  def event_id
    @email_service.event.try(:id)
  end

  def participant_id
    @email_service.participant.try(:id)
  end

  private

  def participant_email_confirmation
    if email_service.email_already_sent?
      @info = 'The event score board link has already been sent to this participant.'
      @confirm = 'Are you sure you want to resend it?'
    else
      @confirm = 'Send the event score board link to participant?'
    end
  end

  def group_email_confirmation
    if email_service.email_already_sent?
      @info = 'The score board link has already been sent to all participants.'
      @confirm = 'Are you sure you want to resend it?'
    else
      @confirm = 'Send the event score board link to all participants?'
    end
  end

  def set_content
    if email_service.participant_email?
      participant_email_confirmation
    else
      group_email_confirmation
    end
  end
end
