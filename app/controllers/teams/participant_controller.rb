class Teams::ParticipantController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def new
    current_event
    current_team
    @participant = Participant.new
  end

  def create
    current_participant.team = current_team
    respond_to do |format|
      if current_participant.save
        format.html { redirect_to event_path(current_participant.event), notice: 'Participant was successfully added.' }
      else
        format.html { redirect_to event_path(current_participant.event), notice: 'Failed to add participant' }
      end
    end
  end

  def destroy
    participant = current_team.participants.find params[:id]
    participant.team = nil
    participant.save
    respond_to do |format|
      format.html { redirect_to event_path(current_participant.event), notice: 'Participant was successfully destroyed.' }
    end
  end

  private

  def current_event
    @event ||= Event.find params[:event_id]
  end

  def current_team
    @team ||= current_user.teams.find params[:team_id]
  end

  def current_participant
    current_user.participants.find_by flyer_id: participant_params[:flyer_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participant_params
    params.require(:participant).permit(:flyer_id, :category_id)
  end
end
