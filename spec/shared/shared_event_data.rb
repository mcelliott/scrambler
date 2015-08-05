RSpec.shared_context 'event participants' do
  let(:event) { create(:event, num_rounds: 6) }
  let(:category_1) { create(:category, :head_down_freefly) }
  let(:category_2) { create(:category, :head_up_freefly) }

  before do
    15.times do
      create(:participant, flyer: create(:flyer), category: category_1, event: event)
    end

    10.times do
      create(:participant, flyer: create(:flyer), category: category_2, event: event)
    end
  end
end
