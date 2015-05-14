require 'rails_helper'

describe TeamParticipantCreator do
  let(:event) { create(:event) }
  let(:round) { create(:round) }
  let(:participant) { create(:participant) }
  let(:team)  { create(:team, event: event, round: round) }

  let(:params) do
    {
      team_id: team.id,
      event_id: event.id,
      participant_id: participant.id,
      placeholder: placeholder
    }
  end

  let(:team_participant) { TeamParticipant.new(params) }
  let(:form) { TeamParticipantForm.new(team_participant) }

  subject { creator }

  context 'when creating an team_participant without placeholder' do
    let(:placeholder) { false }
    let(:creator) { described_class.new(form) }
    it 'should save' do
      expect(subject.save).to be_truthy
    end
  end

  context 'when creating an team_participant with placeholder' do
    let(:placeholder) { true }
    let(:creator) { described_class.new(form) }
    it 'should save' do
      expect(subject.save).to be_truthy
    end
  end
end
