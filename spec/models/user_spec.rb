require 'rails_helper'

describe User, type: :model do

  let!(:admin)   { create(:user, :admin) }
  let!(:manager) { create(:user) }

  context 'without admin' do
    it { expect(User.general).to eq([manager]) }
  end
end
