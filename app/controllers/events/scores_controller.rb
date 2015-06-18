class Events::ScoresController < ApplicationController
  before_action :authenticate_user!
  before_action :load_event

  respond_to :html, :js

  def update
    update_team_participant_scores
    flash[:notice] = 'Score was successfully updated.'
  end

  private

  def update_team_participant_scores
    score = event_score_params[:score]
    team.team_participants.each do |team_participant|
      team_participant.event_score.update_attributes(score: score) unless team_participant.placeholder
    end
  end

  def event_score
    @event_score ||= EventScore.find_by(event_score_params[:score])
  end

  def team
    @team ||= @event.teams.find_by(id: event_score_params[:team_id],
                                   round_id: round.id)
  end

  def round
    @round ||= @event.rounds.find(event_score_params[:round_id])
  end

  def load_event
    @event = Event.find(params[:event_id])
  end

  def event_score_params
    params.require(:event_score).permit(:team_id, :round_id, :score)
  end
end
