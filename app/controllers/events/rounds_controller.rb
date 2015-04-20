class Events::RoundsController < ApplicationController
  before_action :set_event

  def index
  end

  def new
  end

  def create
    event_rounds_creator = EventRoundsCreator.new(params)
    event_rounds_creator.reset
    event_rounds_creator.perform
    respond_to do |format|
      format.json { redirect_to event_rounds_path }
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
