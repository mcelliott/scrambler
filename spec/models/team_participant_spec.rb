require 'rails_helper'

RSpec.describe TeamParticipant, type: :model do
  it { is_expected.to belong_to(:event) }
  it { is_expected.to belong_to(:team) }
  it { is_expected.to belong_to(:participant) }
  it { is_expected.to have_one(:event_score) }
end
