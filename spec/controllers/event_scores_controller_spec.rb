require 'rails_helper'

describe EventScoresController do
  let(:user)        { create(:user) }
  let(:flyer)       { create(:flyer, user: user) }
  let(:category)    { create(:category, user: user) }
  let(:event)       { create(:event, user: user) }
  let(:round)       { create(:round, event: event, user: user) }
  let(:participant) { create(:participant, event: event, user: user, flyer: flyer, category: category) }
  let(:team)        { create(:team, event: event, user: user, category: category, round: round) }
  let(:team_participant) { create(:team_participant, event: event, participant: participant, user: user, team: team) }

  before do
    sign_in user
  end

  describe '#update' do
    let(:event_score) { create(:event_score, event: event, round: round, team_participant: team_participant, user: user, score: 0) }
    let(:params) do
      {
        id: event_score.id,
        event_scores: {
          event_id: event.id,
          team_participant_id: team_participant.id,
          round_id: round.id,
          score: 10
        }
      }
    end

    before do
      xhr :put, :update, params
    end

    it 'should set the score' do
      expect(event_score.reload.score).to eq 10
    end
  end
end
