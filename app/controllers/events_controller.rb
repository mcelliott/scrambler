class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :participant, only: [:show]
  load_and_authorize_resource except: [:new, :generate, :create, :email, :index]
  respond_to :html, :js

  decorates_assigned :event
  decorates_assigned :events, with: PaginatedCollectionDecorator

  def index
    @q = Event.order(event_date: :desc).search(params[:q])
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
    @event = Event.new(event_params)
    flash[:notice] = 'Event was successfully created.' if @event.save
  end

  def update
    flash[:notice] = 'Event was successfully updated.' if @event.update(event_params)
  end

  def destroy
    if @event.destroy
      flash[:notice] = 'Event was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete event.'
    end
  end

  private

  def participant
    @participant = Participant.new
    @participant.event = @event
  end

  def event_params
    params.require(:event).permit(:event_date,
                                  :name,
                                  :category_type,
                                  :team_size,
                                  :num_rounds,
                                  :participant_cost,
                                  :rate_per_minute,
                                  :time_per_round)
  end
end
