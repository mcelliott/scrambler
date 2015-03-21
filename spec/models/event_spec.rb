require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to have_many(:participants) }
  it { is_expected.to have_many(:rounds) }
  it { is_expected.to have_many(:payments) }
  it { is_expected.to have_many(:teams) }
  it { is_expected.to validate_presence_of(:event_date) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:team_size) }
  it { is_expected.to validate_presence_of(:num_rounds) }
  it { is_expected.to validate_numericality_of(:team_size) }
end
