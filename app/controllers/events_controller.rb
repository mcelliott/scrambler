class EventsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  # GET /events
  # GET /events.json
  def index
    @events = current_user.events
  end

  # GET /events/1
  # GET /events/1.json
  def show
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

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to events_path, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
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
    @event = Event.find params[:event_id]
    @event.rounds.delete_all
    @event.num_rounds.times do |num_round|
      round = Round.create!(event: @event, user: current_user, round_number: num_round + 1)
      if round.present?
        @event.participants.shuffle.each do |participant|
          TeamParticipant.create!(user: current_user,
                                  team: new_event_team(participant, round),
                                  event: @event,
                                  participant: participant)
        end
      end
    end
    @event.reload
  end

  private

  def new_event_team(p, round)
    category_id = p.category.id
    return @team[category_id] if @team && @team[category_id] && space_available?(category_id)
    (@team ||= {})[category_id] = round.teams.create(name: "Team #{round.teams.count + 1}",
                                                     category: p.category,
                                                     user: current_user,
                                                     round: round,
                                                     event: @event)
  end

  def space_available?(category_id)
    @team[category_id].team_participants.count < @event.team_size
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:event_date, :location, :name, :team_size, :num_rounds)
  end
end
