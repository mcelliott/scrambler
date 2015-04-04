RSpec.shared_context 'event participants' do
  let(:event) { create(:event, num_rounds: 6) }
  let(:category_1) { create(:category, :head_down_freefly) }
  let(:category_2) { create(:category, :head_up_freefly) }

  before do
    15.times do
      flyer = Flyer.create(name: Faker::Name.name, email: Faker::Internet.email, hours: TunnelHours::BEGINNER)
      participant_params = { flyer_id: flyer.id, category_id: category_1.id }
      ParticipantCreator.new(event, participant_params).perform
    end

    10.times do
      flyer = Flyer.create(name: Faker::Name.name, email: Faker::Internet.email, hours: TunnelHours::BEGINNER)
      participant_params = { flyer_id: flyer.id, category_id: category_2.id }
      ParticipantCreator.new(event, participant_params).perform
    end
    event.reload
  end
end
