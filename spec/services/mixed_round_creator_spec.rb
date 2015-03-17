require 'rails_helper'

describe MixedRoundCreator do
  let(:user)  { create(:user)  }
  let(:event) { create(:event, num_rounds: 6) }
  let(:params) { { mixed_rounds: { "3" => "1", "4" => "1", "5" => "1" } } }
  let(:category_1) { create(:category, :freefly) }
  let(:category_2) { create(:category, :freefly) }

  subject { described_class.new(event, params, {}) }

  before do
    5.times do
      flyer = Flyer.create(user: user, name: Faker::Name.name, email: Faker::Internet.email, hours: TunnelHours::BEGINNER)
      participant_params = { flyer_id: flyer.id, category_id: category_1.id }
      ParticipantCreator.new(event, user, participant_params).perform
    end

    5.times do
      flyer = Flyer.create(user: user, name: Faker::Name.name, email: Faker::Internet.email, hours: TunnelHours::BEGINNER)
      participant_params = { flyer_id: flyer.id, category_id: category_2.id }
      ParticipantCreator.new(event, user, participant_params).perform
    end
  end

  it '#perform' do
    subject.perform
  end
end
