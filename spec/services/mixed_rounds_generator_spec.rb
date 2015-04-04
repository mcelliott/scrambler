require 'rails_helper'
require 'shared/shared_event_data.rb'

describe MixedRoundsGenerator, type: :service do
  include_context 'event participants'
  let(:number_of_mixed_rounds) { 3 }
  let(:params) { { mixed_rounds: { "3" => "1", "4" => "1", "5" => "1" } } }
  subject { described_class }

  before do
    subject.new(event, params).perform
  end

  describe '#perform' do

    it 'should create the correct number of teams' do
      expect(Team.count).to eq(number_of_mixed_rounds * event.number_of_teams)
    end

    it 'should create populated teams' do
      Team.all.each do |team|
        expect(team.team_participants.count).not_to eq(0)
      end
    end

    it 'should team up categories' do
      Team.all.each do |team|
        categories = team.team_participants.pluck(&:id)
        expect(categories).not_to eq(category_2.id)
      end
    end
  end
end
