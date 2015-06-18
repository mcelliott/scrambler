class Events::RoundsController < ApplicationController
  before_action :set_event
  decorates_assigned :event
  decorates_assigned :round

  def index
  end

  def new
  end

  def show
    @round = @event.rounds.includes(:teams).find(params[:id])
    render partial: 'events/teams'
  end

  def create
    @job_id = EventRoundsCreator.perform_async(event.id, mixed_rounds)
    progress.update(5)
    render json: { job_id: @job_id }
  end

  def status
    render json: job_data
  end

  private

  def mixed_rounds
    params[:mixed_rounds] || []
  end

  def job_data
    { progress: pct_complete, status: job_status }
  end

  def pct_complete
    progress.status
  end

  def job_status
    pct_complete == '100' ? 'done' : 'working'
  end

  def progress
    @progress ||= ProgressUpdater.new(@event)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
