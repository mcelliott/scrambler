class Teams::ParticipantController < ApplicationController
  def new
    current_event
    current_team
    @participant = Participant.new
  end

  def create
    team = Team.find params[:participant][:team_id]
    participant = team.participants.build(participant_params)
    respond_to do |format|
      if team.save
        format.html { redirect_to participant.event, notice: 'Participant was successfully added.' }
        format.js
      else
        format.js
        format.html { render :new }
      end
    end
  end

  private

  def current_event
    @event ||= Event.find params[:event_id]
  end

  def current_team
    @team ||= Team.find params[:team_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participant_params
    params.require(:participant).permit(:flyer_id, :category_id, :team_id, :event_id)
  end
end
