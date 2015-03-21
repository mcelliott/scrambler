require 'rails_helper'

RSpec.describe EventScore, type: :model do
  it { is_expected.to validate_presence_of(:round_id) }
  it { is_expected.to validate_presence_of(:event_id) }
  it { is_expected.to validate_presence_of(:team_participant_id) }
  it { is_expected.to validate_presence_of(:score) }
  it { is_expected.to validate_presence_of(:participant_id) }
  it { is_expected.to belong_to(:round) }
  it { is_expected.to belong_to(:event) }
  it { is_expected.to belong_to(:participant) }
  it { is_expected.to belong_to(:team_participant) }
end
