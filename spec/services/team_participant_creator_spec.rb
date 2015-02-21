require 'rails_helper'

describe TeamParticipantCreator do

  let(:user)  { create(:user)  }
  let(:event) { create(:event, user: user) }
  let(:round) { create(:round, user: user) }
  let(:participant) { create(:participant, user: user) }
  let(:team)  { create(:team, event: event, round: round, user: user) }

  context 'when creating an team_participant without placeholder' do
    let(:creator) { described_class.new(event, participant.id, team) }
    subject { creator.perform }

    it 'should be valid' do
      expect(subject).to be
    end

    it 'should belong to the participant' do
      expect(subject.participant).to eq participant
    end

    it 'should not have a placeholder' do
      expect(subject.placeholder).to be_falsy
    end
  end

  context 'when creating an team_participant with placeholder' do
    let(:creator) { described_class.new(event, participant.id, team, true) }
    subject { creator.perform }

    it 'should have a placeholder' do
      expect(subject.placeholder).to be_truthy
    end
  end
end
