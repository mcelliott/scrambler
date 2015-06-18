class TeamParticipantCreator
  attr_reader :form, :team, :event
  delegate :model, to: :form

  def initialize(form)
    @form = form
  end

  def save
    return false unless form.valid?
    form.sync
    success = form.save
    EventScoreCreator.new(form.model).save if success && !model.placeholder
    success
  end

  private

  def round
    model.team.round
  end
end
