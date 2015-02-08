require 'rails_helper'

describe EventsController do
  let(:user)        { create(:user) }
  let(:flyer)       { create(:flyer, user: user) }
  let(:category)    { create(:category, user: user) }
  # let(:event)       { create(:event, user: user) }
  # let(:round)       { create(:round, event: event, user: user) }
  # let(:participant) { create(:participant, event: event, user: user, flyer: flyer, category: category) }
  # let(:team)        { create(:team, event: event, user: user, category: category, round: round) }
  # let(:team_participant) { create(:team_participant, event: event, participant: participant, user: user, team: team) }


end
