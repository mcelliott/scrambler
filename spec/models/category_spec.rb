require 'rails_helper'

describe Category do
  it { should respond_to :name  }
  it { should respond_to :category_type  }

  describe 'name field' do
    context 'valid name' do
      let(:category) { build(:category) }
      it 'should be invalid' do
        expect(category).to be_valid
      end
    end

    context 'with nil name' do
      let(:invalid_category) { build(:category, name: nil) }
      it 'should be invalid' do
        expect(invalid_category).to_not be_valid
      end
    end

    context 'with long name' do
      let(:invalid_category) { build(:category, name: ('a' * 51)) }
      it 'should be invalid' do
        expect(invalid_category).to_not be_valid
      end
    end
  end

  describe 'category_type field' do
    let(:invalid_category) { build(:category, category_type: nil) }
    it 'should be invalid' do
      expect(invalid_category).to_not be_valid
    end
  end
end
