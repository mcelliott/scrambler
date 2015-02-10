class EventPresenter < BasePresenter
  include EventsHelper

  def initialize(event)
    super event.reload
  end

  def participants
    @participants ||= @object.participants.includes(:category, :flyer).group_by { |p| p.category }
  end

  def participants?
    participants.present?
  end

  def rounds
    @rounds ||= @object.rounds
  end

  def event
    @object
  end
end
