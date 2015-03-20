class ParticipantDecorator < Draper::Decorator
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
end
