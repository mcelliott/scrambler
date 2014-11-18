class EventPresenter < BasePresenter
  include EventsHelper

  def initialize(event)
    super event
  end

  def participants
    @object.participants
  end

  def participants?
    participants.present?
  end

  def rounds
    @object.rounds
  end

end
