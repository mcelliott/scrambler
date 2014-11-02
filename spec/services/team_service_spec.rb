require 'rails_helper'

describe TeamService do

  let(:event)            { create(:event) }
  let(:team_service)     { TeamService.new(event) }
  let(:num_participants) { 6 }
  let(:category)         { create(:category, user: event.user) }

  before do
    num_participants.times do
      create(:participant, event: event, category: category, user: event.user)
    end
  end

  context 'create_team_participants' do
    let(:num_team_participants) { event.num_rounds * num_participants }
    it 'should create team participants' do
      expect{ team_service.create_team_participants }.to change{ TeamParticipant.count }.by(num_team_participants - 2)
    end

    context '2 team participants' do
      before { team_service.create_team_participants }
      it 'should create both team participants with correct event_id' do
        expect(TeamParticipant.first.event_id).to eq event.id
        expect(TeamParticipant.last.event_id).to eq event.id
      end

      it 'should create two teams' do
        event_rounds_first = event.rounds.first
        expect(event_rounds_first.teams.size).to eq 3
      end

      it 'should create teams with two participants' do
        event_rounds_first = event.rounds.first
        expect(event_rounds_first.teams.first.team_participants.size).to eq 2
      end

      it 'should create 3 rounds' do
        expect(event.rounds.size).to eql event.num_rounds
      end
    end
  end
end
