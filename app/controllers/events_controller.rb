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
    @event = Event.includes(:rounds, :participants).find params[:event_id]
    @event.rounds.destroy_all
    TeamService.new(@event).create_team_participants
    @event_presenter = EventPresenter.new(@event.reload)
  end

  def email
    @event = Event.includes(:rounds, :participants).find params[:event_id]
    if @event.email_count
      Rails.logger.info("Already send emails for event #{@event.name}")
    else
      SendEventWorker.perform_async(@event.id)
      Rails.logger.info("Emails sent for event #{@event.name}")
      @event.update_attributes(email_count: @event.email_count + 1)
    end
    flash[:notice] = 'Participants have been emailed.'
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:event_date, :location, :name, :team_size, :num_rounds)
  end
end
