class EventsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:new, :generate, :create, :email, :index]
  respond_to :html, :js

  decorates_assigned :event
  decorates_assigned :events, with: PaginatedCollectionDecorator

  def index
    @q = current_user.events.order(event_date: :desc).search(params[:q])
    @events = @q.result.page(params[:page])
  end

  def show
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
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      format.js
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate
    ts = TeamService.new(params)
    ts.create_team_participants
    @event = ts.event.reload
  end

  def email
    EmailService.new(params).send
    flash[:notice] = 'Participants have been emailed.'
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:event_date, :location, :name, :team_size, :num_rounds, :participant_cost)
  end
end
