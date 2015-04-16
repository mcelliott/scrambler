class ParticipantDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  delegate_all

  def payed?
    payment.completed_at.present?
  end

  def name
    flyer.name
  end

  def flyer_hours
    flyer.hours_humanize
  end

  def data
    {
      name: name,
      number: object.number,
      path: event_participant_path(object, event_id: object.event.id)
    }
  end
end
