require 'rails_helper'

describe TeamParticipantCreator do

  let(:user)  { create(:user)  }
  let(:event) { create(:event, user: user) }
  let(:round) { create(:round, user: user) }
  let(:participant) { create(:participant, user: user) }
  let(:team)  { create(:team, event: event, round: round, user: user) }
  let(:creator) { described_class.new(event, round, participant.id, team) }

  context 'when creating an team_participant' do
    subject { creator.perform }

    it 'should be valid' do
      expect(subject).to be
    end

    it 'should belong to the participant' do
      expect(subject.participant).to eq participant
    end
  end
end
