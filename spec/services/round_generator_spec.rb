require 'rails_helper'
require 'shared/shared_event_data.rb'


describe RoundGenerator, type: :service do
  include_context 'event participants'

  subject do
    described_class.new(event, [])
  end

  describe '#build' do
    before { subject.build }
    it 'should create the correct number of rounds' do
      expect(subject.rounds.count).to eq(event.num_rounds)
    end
  end

  describe '#generate' do
    before { subject.generate }
    it 'should create the correct number of teams' do
      expect(subject.rounds.values.count).not_to eq(event.number_of_teams * event.num_rounds)
    end
  end
end
