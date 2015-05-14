require 'rails_helper'

describe EventScoreCreator do
  let(:participant)      { create(:participant) }
  let(:team_participant) { create(:team_participant, participant: participant) }
  let(:creator)          { described_class.new(team_participant) }

  context 'when creating an event score for a team_participant' do
    subject { creator }

    it 'should be truthy' do
      expect(subject.save).to be_truthy
    end
  end
end
