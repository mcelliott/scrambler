class Teams::ParticipantController < ApplicationController
  include UndoDelete
  authorize_resource
  before_action :authenticate_user!
  respond_to :html, :js

  decorates_assigned :event
  decorates_assigned :team
  decorates_assigned :team_participant

  def new
    team_participant = TeamParticipant.new(event: current_event, team: current_team)
    @form = TeamParticipantForm.new(team_participant)
  end

  def create
    @team_participant = TeamParticipant.new
    @form = TeamParticipantForm.new(@team_participant)
    @form.update!(params[:team_participant])

    if TeamParticipantCreator.new(@form).save
      @success = true
      flash[:notice] = 'Participant was successfully added.'
    else
      flash[:notice] = 'Failed to add Participant.'
    end
  end

  def destroy
    @team_participant = current_team.team_participants.find(params[:id])
    if @team_participant.destroy
      flash[:notice] = "Team Participant was successfully deleted. #{undo_link(team_participant)}"
    else
      flash[:alert] = 'Failed to delete team participant.'
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

  def participant_params
    params.require(:team_participant).permit(:id, :category_id, :placeholder)
  end
end
