require 'rails_helper'

describe RoundCreator do
  let(:event)        { create(:event) }
  let(:round_number) { 0 }
  let(:creator)      { described_class.new(event, round_number) }

  context 'when creating a round for an event' do
    subject { creator.perform }

    it 'should be valid' do
      expect(subject).to be
    end

    it 'should belong to the event' do
      expect(subject.event).to eq event
    end

    it 'should belong to the category' do
      expect(subject.round_number).to eq round_number + 1
    end
  end
end
