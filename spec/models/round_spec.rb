require 'rails_helper'

RSpec.describe Round, type: :model do
  it { is_expected.to validate_presence_of(:event_id) }
  it { is_expected.to validate_presence_of(:round_number) }
  it { is_expected.to belong_to(:event) }
  it { is_expected.to have_many(:teams) }
  it { is_expected.to have_many(:event_scores) }
  it { is_expected.to have_many(:team_participants) }
end
