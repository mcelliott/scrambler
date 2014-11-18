class EventsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:new, :generate]
  respond_to :html, :js

  def index
    @q = current_user.events.order(event_date: :desc).search(params[:q])
    @events = @q.result.page(params[:page])
  end

  def show
    @event = Event.includes(:participants, :rounds).find params[:id]
    @event_presenter = EventPresenter.new(@event)
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = current_user.events.build(event_params)
    flash[:notice] = 'Event was successfully created.' if @event.save
  end

  def update
    flash[:notice] = 'Event was successfully updated.' if @event.update(event_params)
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate
    @event = Event.includes(:rounds, :participants).find params[:event_id]
    @event.rounds.delete_all
    TeamService.new(@event).create_team_participants
    @event_presenter = EventPresenter.new(@event.reload)
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:event_date, :location, :name, :team_size, :num_rounds)
  end
end
