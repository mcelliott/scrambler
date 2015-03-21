require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { is_expected.to validate_presence_of(:event_id) }
  it { is_expected.to validate_presence_of(:participant_id) }
  it { is_expected.to belong_to(:event) }
  it { is_expected.to belong_to(:participant) }
end
