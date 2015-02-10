class PaymentDecorator < Draper::Decorator
  delegate_all

  decorates_association :participant
  decorates_association :event

  def participant_name
    participant.name
  end

  def payment_status
    participant.payed? ? 'paid' : 'unpaid'
  end
end
