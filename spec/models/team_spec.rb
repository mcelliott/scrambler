require 'rails_helper'

RSpec.describe Team, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:category_id) }
  it { should belong_to(:category) }
  it { should validate_presence_of(:event_id) }
  it { should belong_to(:event) }
  it { should validate_presence_of(:round_id) }
  it { should belong_to(:round) }
end
