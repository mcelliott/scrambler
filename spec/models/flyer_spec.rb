require 'rails_helper'

describe Flyer do
  it { should respond_to :name  }
  it { should respond_to :hours }

  describe 'name field' do
    context 'valid name' do
      let(:flyer) { build(:flyer) }
      it 'should be invalid' do
        expect(flyer).to be_valid
      end
    end

    context 'with nil name' do
      let(:invalid_flyer) { build(:flyer, name: nil) }
      it 'should be invalid' do
        expect(invalid_flyer).to_not be_valid
      end
    end

    context 'with long name' do
      let(:invalid_flyer) { build(:flyer, name: ('a' * 51)) }
      it 'should be invalid' do
        expect(invalid_flyer).to_not be_valid
      end
    end
  end

  describe 'hours field' do
    context 'with less than zero hours' do
      let(:invalid_flyer) { build(:flyer, hours: -1) }
      it 'should be invalid' do
        expect(invalid_flyer).to_not be_valid
      end
    end

    context 'with zero hours' do
      let(:flyer) { build(:flyer, hours: 0) }
      it 'should be valid' do
        expect(flyer).to be_valid
      end
    end
  end
end
