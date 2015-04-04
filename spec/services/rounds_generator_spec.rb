require 'rails_helper'
require 'shared/shared_event_data.rb'

describe RoundsGenerator, type: :service do
  include_context 'event participants'
  subject { described_class }

  before { subject.new(event, {}).perform }

  describe '#perform' do
    it 'should create the correct number of teams' do
      expect(Team.count).to eq(event.number_of_teams * event.num_rounds)
    end

    it 'should create populated teams' do
      Team.all.each do |team|
        expect(team.team_participants.count).not_to eq(0)
      end
    end

    it 'should team up categories' do
      Team.all.each do |team|
        expect(team.team_participants.first.category.id).to eq(team.team_participants.last.category.id)
      end
    end
  end
end
