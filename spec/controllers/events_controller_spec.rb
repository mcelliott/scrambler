require 'rails_helper'

describe EventsController do
  let(:flyer)       { create(:flyer) }
  let(:category)    { create(:category) }
  let(:event)       { create(:event) }
  let(:round)       { create(:round, event: event) }
  let(:participant) { create(:participant, event: event, flyer: flyer, category: category) }
  let(:team)        { create(:team, event: event, category: category, round: round) }
  let(:team_participant) { create(:team_participant, event: event, participant: participant, team: team) }

  describe '#generate_mixed' do
    before { xhr :get, :generate_mixed, event_id: event.id, mixed_rounds: [] }
  end
end
