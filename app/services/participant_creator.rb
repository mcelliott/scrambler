class ParticipantCreator
  attr_reader :form
  delegate :model, to: :form

  def initialize(form)
    @form = form
  end

  def save
    return false unless form.valid?
    form.sync
    model.number = Participant.participant_number(event)
    form.save do |nested|
      model.update_attributes(nested)
      model.create_payment(event: event, amount: event.participant_cost)
    end
  end

  private

  def event
    model.event
  end
end
