class Events::RoundsController < ApplicationController
  before_action :set_event
  decorates_assigned :event

  def index
  end

  def new
  end

  def create
    event_rounds_creator = EventRoundsCreator.new(params)
    event_rounds_creator.reset
    event_rounds_creator.perform
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
