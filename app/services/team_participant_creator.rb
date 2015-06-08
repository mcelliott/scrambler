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
      EventScoreCreator.new(form.model).save unless model.placeholder
      model.update_attributes(nested)
    end
  end

  private

  def round
    model.team.round
  end
end
