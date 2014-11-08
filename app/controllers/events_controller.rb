class EventsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:new, :generate]
  respond_to :html, :js

  # GET /events
  # GET /events.json
  def index
    @events = current_user.events.order(event_date: :asc)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.includes(:participants, :rounds).find params[:id]
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.build(event_params)
    flash[:notice] = 'Event was successfully created.' if @event.save
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    flash[:notice] = 'Event was successfully updated.' if @event.update(event_params)
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate
    @event = Event.includes(:rounds).find params[:event_id]
    @event.rounds.delete_all
    TeamService.new(@event).create_team_participants
    @event.reload
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:event_date, :location, :name, :team_size, :num_rounds)
  end
end
