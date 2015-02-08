class TeamsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :team_view]
  load_and_authorize_resource except: :team_view
  skip_authorization_check only: :team_view

  # GET /teams
  # GET /teams.json
  def index
    @presenter = TeamParticipantPresenter.new(event)
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

  def team_view
    @event = Event.includes(:participants, :rounds).find_by(uuid: params[:uuid])
    @presenter = TeamParticipantPresenter.new(@event)
    render :index
  end

  private

  def event
    @event ||= Event.includes(:participants, :rounds).find params[:event_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:name, :event_id)
  end
end
