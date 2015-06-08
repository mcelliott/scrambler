require 'rails_helper'

describe Events::ScoresController do
  let(:user)        { create(:user)  }
  let(:flyer)       { create(:flyer) }
  let(:category)    { create(:category) }
  let(:event)       { create(:event) }
  let(:round)       { create(:round, event: event) }
  let(:participant) { create(:participant, event: event, flyer: flyer, category: category) }
  let(:team)        { create(:team, event: event, category: category, round: round) }
  let(:team_participant) { create(:team_participant, event: event, participant: participant, team: team) }

  before do
    sign_in user
  end

  describe '#update' do
    let(:event_score) { create(:event_score,
                               event: event,
                               round: round,
                               participant: participant,
                               team_participant: team_participant,
                               score: 0) }
    let(:params) do
      {
        id: event_score.id,
        event_id: event.id,
        event_score: {
          team_id: team.id,
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
