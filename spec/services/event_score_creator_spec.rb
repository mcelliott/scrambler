require 'rails_helper'

describe EventScoreCreator do
  let(:event) { create(:event) }
  let(:round) { create(:round) }
  let(:participant)      { create(:participant) }
  let(:team_participant) { create(:team_participant, participant: participant) }
  let(:creator)          { described_class.new(event, team_participant, round) }

  context 'when creating an event score for a team_participant' do
    subject { creator.perform }

    it 'should be valid' do
      expect(subject).to be
    end

    it 'should belong to the participant' do
      expect(subject.participant).to eq participant
    end

    it 'should belong to the team_participant' do
      expect(subject.team_participant).to eq team_participant
    end

    it 'should belong to the event' do
      expect(subject.round).to eq round
    end
  end
end
