class TeamParticipantCreator
  attr_reader :form, :team, :event
  delegate :model, to: :form

  def initialize(form)
    @form = form
  end

  def save
    return false unless form.valid?
    form.sync
    form.save do |nested|
      model.update_attributes(nested)
      EventScoreCreator.new(form.model).save
    end
  end

  private

  def round
    model.team.round
  end
end
