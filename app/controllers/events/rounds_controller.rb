class Events::RoundsController < ApplicationController
  before_action :set_event

  def index
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
