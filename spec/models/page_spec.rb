require 'rails_helper'

RSpec.describe Page, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:slug) }
  it { is_expected.to validate_presence_of(:title) }
end
