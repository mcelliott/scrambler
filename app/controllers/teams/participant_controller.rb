class Teams::ParticipantController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  respond_to :html, :js

  decorates_assigned :event
  decorates_assigned :team
  decorates_assigned :team_participant

  def new
    current_event
    current_team
    @team_participant = TeamParticipant.new
  end

  def create
    @team_participant = TeamParticipantCreator.new(current_event,
                                                   current_participant.id,
                                                   current_team,
                                                   participant_params[:placeholder]).perform
    flash[:notice] = 'Participant was successfully added.' if @team_participant
  end

  def destroy
    @team_participant = current_team.team_participants.find(params[:id])
    @team_participant.destroy
    respond_to do |format|
      flash[:notice] = 'Participant was successfully deleted.'
      format.html { redirect_to event_path(@team_participant.event) }
      format.js
    end
  end

  private

  def next_participant
    current_event.participants.count + 1
  end

  def current_event
    @event ||= Event.find params[:event_id]
  end

  def current_team
    @team ||= Team.find params[:team_id]
  end

  def current_participant
    current_event.participants.find participant_params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participant_params
    params.require(:team_participant).permit(:id, :category_id, :placeholder)
  end
end
