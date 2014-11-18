class TeamsController < ApplicationController
  before_action :authenticate_user!, except: :index
  load_and_authorize_resource

  # GET /teams
  # GET /teams.json
  def index
    @event = Event.find params[:event_id]
    @presenter = TeamParticipantPresenter.new(@event)
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    event = @team.event
    @team.destroy
    respond_to do |format|
      format.html { redirect_to event, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:name, :event_id)
  end
end
