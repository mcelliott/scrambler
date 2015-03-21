require 'rails_helper'

RSpec.describe TeamParticipant, type: :model do
  it { is_expected.to belong_to(:event) }
  it { is_expected.to belong_to(:team) }
  it { is_expected.to belong_to(:participant) }
  it { is_expected.to have_one(:event_score) }
  it { is_expected.to validate_presence_of(:participant_id) }
  it { is_expected.to validate_presence_of(:event_id) }
  it { is_expected.to validate_presence_of(:team_id) }
end
