require 'rails_helper'

describe TeamService do
  let!(:user)        { create(:user) }
  let(:event)        { create(:event, user: event) }
  let(:team_service) { TeamService.new(event) }

  describe 'create_team_participants' do
    it 'should create team participants' do
      expect(team_service.create_team_participants).to be_truthy
    end
  end
end
