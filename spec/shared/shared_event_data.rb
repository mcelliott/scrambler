RSpec.shared_context 'event participants' do
  let(:event) { build_stubbed(:event, num_rounds: 6) }
  let(:category_1) { build_stubbed(:category, :head_down_freefly) }
  let(:category_2) { build_stubbed(:category, :head_up_freefly) }

  before do
    15.times do
      flyer = Flyer.create(name: Faker::Name.name, email: Faker::Internet.email, hours: TunnelHours::BEGINNER)
      participant_params = { flyer_id: flyer.id, category_id: category_1.id }
      participant = Participant.new(event: event)
      form = ParticipantForm.new(participant)
      form.update!(participant_params)
      ParticipantCreator.new(form).save
    end

    10.times do
      flyer = Flyer.create(name: Faker::Name.name, email: Faker::Internet.email, hours: TunnelHours::BEGINNER)
      participant_params = { flyer_id: flyer.id, category_id: category_2.id }
      participant = Participant.new(event: event)
      form = ParticipantForm.new(participant)
      form.update!(participant_params)
      ParticipantCreator.new(form).save
    end
  end
end
