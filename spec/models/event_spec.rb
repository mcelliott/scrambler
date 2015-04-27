require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to have_many(:participants) }
  it { is_expected.to have_many(:rounds) }
  it { is_expected.to have_many(:payments) }
  it { is_expected.to have_many(:teams) }

  it { is_expected.to validate_presence_of(:event_date) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:team_size) }
  it { is_expected.to validate_presence_of(:num_rounds) }

  it { is_expected.to validate_numericality_of(:team_size).is_greater_than_or_equal_to(2) }
  it { is_expected.to validate_numericality_of(:participant_cost) }
  it { is_expected.to validate_numericality_of(:rate_per_minute) }

  it { should validate_inclusion_of(:category_type).in_array(CategoryType.list)  }

  let(:event) { build_stubbed(:event) }
  describe 'title' do
    it 'should have title' do
      expect(event.title).to eq("#{event.name} - #{event.event_date}")
    end
  end

  describe 'categories_participants' do
    let(:participant) { build_stubbed(:participant) }

    before do
      allow_any_instance_of(Event).to receive(:participants).and_return([participant])
    end

    it 'should return participants by category' do
      expect(event.categories_participants).to be_a(Hash)
      expect(event.categories_participants).to have_key(participant.category)
    end
  end

  describe 'number_of_teams' do
    let(:participant_1) { build_stubbed(:participant) }
    let(:participant_2) { build_stubbed(:participant) }

    before do
      allow_any_instance_of(Event).to receive(:participants).and_return([participant_1, participant_2])
    end

    it 'should return number_of_teams' do
      expect(event.number_of_teams).to eq(event.participants.count / event.team_size)
    end
  end
end
