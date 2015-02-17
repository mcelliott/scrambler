class Teams::ParticipantController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  respond_to :html, :js

  decorates_assigned :team
  decorates_assigned :team_participant

  def new
    current_event
    current_team
    @team_participant = TeamParticipant.new
  end

  def create
    @team_participant = current_user.team_participants.build(team: current_team,
                                                        event: current_event,
                                                        participant: current_participant,
                                                        placeholder: participant_params[:placeholder])


    if @team_participant.save
      create_event_score
      flash[:notice] = 'Participant was successfully added.'
    end
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


  def create_event_score
    # TODO
    EventScore.create!(user: current_event.user,
                       team_participant: @team_participant,
                       round: current_team.round,
                       event: current_event,
                       participant: current_participant,
                       score: 0)
  end

  def next_participant
    current_event.participants.count + 1
  end

  def current_event
    @event ||= Event.find params[:event_id]
  end

  def current_team
    @team ||= current_user.teams.find params[:team_id]
  end

  def current_participant
    current_event.participants.find participant_params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participant_params
    params.require(:team_participant).permit(:id, :category_id, :placeholder)
  end
end
