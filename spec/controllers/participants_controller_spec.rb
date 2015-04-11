require 'rails_helper'

describe ParticipantsController do
  render_views
  let(:user)        { create(:user) }
  let(:event)       { create(:event) }
  let(:category)    { create(:category) }
  let(:flyer)       { create(:flyer) }

  before do
    sign_in user
  end

  describe '#new' do
    before { xhr :get, :new, { event_id: event.id } }
    it 'should render new' do
      expect(response).to be_success
      expect(response).to render_template('new')
    end
  end

  describe '#show' do
    let!(:participant) { create(:participant, event: event, flyer: flyer, category: category) }
    before { xhr :get, :show, { event_id: event.id, id: participant.id } }
    it 'should render new' do
      expect(response).to be_success
      expect(response).to render_template('show')
    end
  end

  describe '#create' do
    let(:form_params) { { flyer_id: flyer, category_id: category.id, event_id: event.id } }
    let(:participant_number) { Participant.participant_number(event) }

    subject { xhr :post, :create, { event_id: event.id, participant: form_params } }

    it 'should create the participant' do
      expect{ subject }.to change(Participant, :count).by(1)
    end

    it 'should increment the participant number' do
      subject
      expect(Participant.last.number).to eq 1
    end

    it 'should create a payment' do
      expect{ subject }.to change(Payment, :count).by(1)
    end
  end

  describe '#destroy' do
    let!(:participant) { create(:participant, event: event, flyer: flyer, category: category) }
    it 'should delete the participant' do
      expect{
        xhr :delete, :destroy, { event_id: event.id, id: participant.id }
      }.to change(Participant, :count).by(-1)
    end

    context 'with generated teams' do
      before do
        5.times do
          create(:participant, event: event, category: category)
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
