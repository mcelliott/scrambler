require 'rails_helper'

describe TeamCreator do
  let(:event)    { create(:event)    }
  let(:category) { create(:category) }
  let(:round)    { create(:round, event: event)    }
  let(:num_participants)     { 6 }
  let(:creator)  { described_class.new(1, event, round, category) }

  context 'when creating a team for a round' do
    subject { creator.perform }

    it 'should be valid' do
       expect(subject).to be
    end

    it 'should belong to the event' do
      expect(subject.event).to eq event
    end

    it 'should belong to the round' do
      expect(subject.round).to eq round
    end

    it 'should belong to the category' do
      expect(subject.category).to eq category
    end

    it 'should have zero team_participants' do
      expect(subject.team_participants).to be_empty
    end
  end
end
