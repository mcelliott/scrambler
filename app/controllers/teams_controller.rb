class TeamsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  # GET /teams
  # GET /teams.json
  def index
    @event = current_user.events.find params[:event_id]
    @teams = @event.teams
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
