require 'rails_helper'

RSpec.describe Team, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:category_id) }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to validate_presence_of(:event_id) }
  it { is_expected.to belong_to(:event) }
  it { is_expected.to validate_presence_of(:round_id) }
  it { is_expected.to belong_to(:round) }
end
