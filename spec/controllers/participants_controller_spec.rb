require 'rails_helper'

describe ParticipantsController do
  let(:user)        { create(:user)  }
  let(:event)       { create(:event,    user: user) }
  let(:category)    { create(:category) }
  let(:flyer)       { create(:flyer,    user: user) }
  let!(:participant) { create(:participant,
                              user: user,
                              event: event,
                              flyer: flyer,
                              category: category) }

  before do
    sign_in user
  end

  describe '#create' do
    let(:flyer_2) { create(:flyer, user: user) }
    let(:form_params) { { flyer_id: flyer_2, category_id: category.id, event_id: event.id } }
    let(:participant_number) { Participant.participant_number(event) }
    it 'should create the participant' do
      expect{
        xhr :post, :create, { event_id: event.id, participant: form_params }
      }.to change(Participant, :count).by(1)
    end

    it 'should increment the participant number' do
      xhr :post, :create, { event_id: event.id, participant: form_params }
      expect(Participant.last.number).to eq 1
    end

    it 'should create a payment' do
      expect{
        xhr :post, :create, { event_id: event.id, participant: form_params }
      }.to change(Payment, :count).by(1)
    end
  end

  describe '#destroy' do
    it 'should delete the participant' do
      expect{
        xhr :delete, :destroy, { event_id: event.id, id: participant.id }
      }.to change(Participant, :count).by(-1)
    end

    context 'with generated teams' do
      before do
        5.times do
          create(:participant, user: user, event: event, category: category)
        end
        EventRoundsCreator.new({ event_id: event.id }).perform
      end

      it 'should delete the team_participant for each round' do
        expect{
          xhr :delete, :destroy, { event_id: event.id, id: participant.id }
        }.to change(TeamParticipant, :count).by(- event.num_rounds)
      end
    end
  end
end
