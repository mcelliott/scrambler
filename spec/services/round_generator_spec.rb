require 'rails_helper'
require 'shared/shared_event_data.rb'


describe RoundGenerator, type: :service do
  pending('todo') do
  include_context 'event participants'

  let(:event) { create(:event) }
  let!(:category_1) { create(:category, :head_up_freefly) }
  let!(:category_2) { create(:category, :head_down_freefly) }
  let!(:category_3) { create(:category, :mixed) }

  let(:generator) do
    described_class.new(event, [])
  end

  subject { generator.perform }

  describe '#perform' do
    it 'should create the correct number of rounds' do
      expect(generator.rounds.keys.count).to eq(event.num_rounds)
    end

    it 'should create the correct number of teams' do
      expect(generator.rounds.values.count).not_to eq(event.number_of_teams * event.num_rounds)
    end
  end
end
end