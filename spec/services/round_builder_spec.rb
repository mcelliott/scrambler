require 'rails_helper'

describe RoundBuilder, type: :service do
  let(:event) { build_stubbed(:event) }

  subject { described_class.new(event, mixed_rounds) }

  describe 'without mixed rounds' do
    let(:mixed_rounds) { [] }
    before { subject.build }
    it 'should build 6 rounds' do
      expect(subject.rounds.size).to eq(event.num_rounds)
    end
  end

  describe 'with mixed rounds' do
    let(:mixed_rounds) { ['1','2','3'] }
    before { subject.build }
    it 'should build 6 rounds' do
      expect(subject.rounds.size).to eq(event.num_rounds)
    end
  end
end
