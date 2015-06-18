class TeamsController < ApplicationController
  before_action :authenticate_user!, except: :team_view
  before_action :set_event, except: :team_view
  load_and_authorize_resource except: :team_view
  skip_authorization_check only: :team_view

  decorates_assigned :team
  decorates_assigned :event

  def index
    @leader_board = LeaderBoard.new(@event).results
  end

  def destroy
    if @team.destroy
      flash[:notice] = 'Team was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete team.'
    end
  end

  def team_view
    @event = Event.includes(:participants, :rounds).find_by(uuid: params[:uuid])
    if @event
      @leader_board = LeaderBoard.new(@event).results
      render :index
    else
      redirect_to root_path, alert: 'Cannot find event scores'
    end
  end

  private

  def set_event
    @event = Event.find params[:event_id]
  end
end
