class ParticipantsController < ApplicationController
  before_action :authenticate_user!, except: :show
  load_and_authorize_resource

  decorates_assigned :event
  decorates_assigned :participant
  decorates_assigned :team_participant

  # GET /participants/new
  def new
    current_event
    @q = current_user.flyers.order(name: :asc).search(params[:q])
    @flyers = @q.result.page(params[:page]).per(10)
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = current_user.participants.build(participant_params.merge(event_id: current_event.id))
    @participant.number = Participant.participant_number(current_event)
    @participant.create_payment(event: current_event, amount: current_event.participant_cost)
    if @participant.save
      @success = true
      flash[:notice] = 'Participant was successfully created.'
    else
      flash[:alert] = 'Failed to add Participant to event.'
    end
    event.reload
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    destroy_team_participant
    @participant.destroy
    respond_to do |format|
      flash[:notice] = 'Participant was successfully deleted.'
      format.html { redirect_to event_path(@participant.event) }
      format.js
    end
  end

  def show
    @participant = Participant.find(params[:id])
  end

  private

  def destroy_team_participant
    @team_participant = TeamParticipant.find_by(participant_id: @participant.id)
    @team_participant.destroy! if @team_participant.present?
  end

  def current_event
    @event ||= Event.find params[:event_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participant_params
    params.require(:participant).permit(:flyer_id, :category_id)
  end
end
