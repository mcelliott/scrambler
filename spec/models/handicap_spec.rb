require 'rails_helper'

RSpec.describe Handicap, type: :model do
  subject { create(:handicap) }

  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:hours) }
end
