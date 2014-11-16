class EventScoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event_score

  respond_to :html, :js

  def update
    flash[:notice] = 'Score was successfully updated.' if @event_score.update(score: event_score_params.delete(:score))
  end

  private

  def set_event_score
    @event_score = EventScore.find_by event_score_params.delete_if { |key, value| key == 'score' }
  end

  def event_score_params
    params.require(:event_scores).permit(:event_id, :team_participant_id, :round_id, :score)
  end
end
